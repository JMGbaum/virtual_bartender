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

  def decisiontrees
    training_data = []
    training_labels = []
    Recipe.all.each do |recipe|
      training_data << recipe.format_for_tree
      training_labels << user_recipes.exists?(recipe_id: recipe.id) ? "1" : "0"
    end
    
    # estimator = Rumale::Tree::DecisionTreeClassifier.new
    # estimator.fit(training_data, training_labels)
    # estimator.tree
  
    
    



  end 
end
