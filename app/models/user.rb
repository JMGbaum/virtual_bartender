class User < ApplicationRecord
    has_many :user_recipes, dependent: :destroy, inverse_of: :user
    has_many :recipes, through: :user_recipes, inverse_of: :users

    has_many :ingredient_items, dependent: :destroy, inverse_of: :user
    has_many :ingredients, through: :ingredient_items, inverse_of: :users

    before_save { email.downcase! }
    validates(:first_name, :last_name, presence: true, length: { maximum: 50 })
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates(:email, presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false })
    has_secure_password
    validates(:password, presence: true, length: { minimum: 6 })

    # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def top_tag_recipes(liked: true)
      top_tag = u.saved_recipe_tags_histogram(liked:).max_by { |k, v| v }[0]
      Tag.find_by(name: top_tag).recipes.where.not(id: u.recipes.ids)
  end

  # https://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient
  def compare_to_saved_recipes(recipe, liked: true)
      t1 = recipe.tags
      t2 = saved_recipe_tags(liked:)
      t3 = t1.intersection(t2)

      2 * t3.count.to_f / (t1.count + t2.count)
  end

  def saved_recipe_tags(liked: true)
      tags = []

      recipes.where('user_recipes.liked' => liked).each do |recipe|
          tags.concat(recipe.tags)
      end

      tags.uniq
  end

  def saved_recipe_tags_histogram(liked: true)
      tags = {}

      recipes.where('user_recipes.liked' => liked).each do |recipe|
          tags.merge!(recipe.weighted_tags_histogram) { |_k, v1, v2| v1 + v2 }
      end

      tags
  end

  def predict_recipe(recipe)
    @tree ||= generate_decision_tree

    @tree.predict(recipe.format_for_decision_tree(self))
  end

  private

  def generate_decision_tree
    labels = ['similarity_liked', 'similarity_disliked']

    training = user_recipes.map do |ur|
      recipe = ur.recipe
      [compare_to_saved_recipes(recipe), compare_to_saved_recipes(recipe, liked: false), ur.liked? ? 'recommended' : 'not recommended']
    end

    tree = DecisionTree::ID3Tree.new(labels, training, 'not recommended', similarity_liked: :continuous, similarity_disliked: :continuous)
    tree.train

    tree
  end
end
