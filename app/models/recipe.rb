class Recipe < ApplicationRecord
    has_many :user_recipes, dependent: :destroy, inverse_of: :recipe
    has_many :users, through: :user_recipes, inverse_of: :recipes


    belongs_to :author, class_name: 'User', optional: true

    has_many :recipe_ingredients, dependent: :destroy, inverse_of: :recipe
    has_many :ingredients, through: :recipe_ingredients, source: :mixable, source_type: 'Ingredient', inverse_of: :recipes
    has_many :ingredient_tags, through: :recipe_ingredients, source: :mixable, source_type: 'Tag', inverse_of: :recipes

    has_one_attached :image

    validates :title, presence: true

    def tags
        t = ingredients.joins(:tags).pluck('tags.name')
        it = ingredient_tags.pluck(:name)

        (t + it).uniq
    end

    def weighted_tags_histogram
        t = ingredients.joins(:tags).group('tags.name').count
        it = ingredient_tags.group(:name).count.transform_values { |v| v * 5 } # multiply by five for ingredient tags

        t.merge(it) { |k, v1, v2| v1 + v2 }
    end

    def format_for_decision_tree(user)
        t = weighted_tags_histogram.sort_by { |_k, v| v }
        [user.compare_to_saved_recipes(self), user.compare_to_saved_recipes(self, liked: false), t[-1]&.at(0), t[-2]&.at(0), t[-3]&.at(0), t[2]&.at(0), t[1]&.at(0), t[0]&.at(0)]
    end
end