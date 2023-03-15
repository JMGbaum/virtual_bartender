class RecipeIngredientTag < ApplicationRecord
    belongs_to :recipe, inverse_of: :recipe_ingredient_tags
    belongs_to :tag, inverse_of: :recipe_ingredient_tags

    validates :recipe_id, presence: true
    validates :tag_id, presence: true
    validates :amount, presence: true
    validates :units, presence: true

    enum units: { 
        part: 0,
        ounce: 1,
        centiliter: 2,
        milliliter: 3,
        liter: 4,
        teaspoon: 5,
        tablespoon: 6,
        cup: 7,
        pint: 8,
        quart: 9,
        gallon: 10,
        custom: 11,
    }

    # Returns the units abbreviation if there is one
    def units_abbreviation
        case units
        when /^ounce$/
            'oz'
        when /^centiliter$/
            'cl'
        when /^milliliter$/
            'ml'
        when /^liter$/
            'L'
        when /^teaspoon$/
            'tsp'
        when /^tablespoon$/
            'tbsp'
        when /^pint$/
            'pt'.pluralize(amount)
        when /^quart$/
            'qt'.pluralize(amount)
        when /^gallon$/
            'gal'.pluralize(amount)
        when /^custom$/
            custom_unit.pluralize(amount)
        else
            units.pluralize(amount)
        end
    end

    # Returns the custom unit or the full unit name
    def units_label
        return custom_unit.pluralize(amount) if units =~ /^custom$/

        units.pluralize(amount)
    end
end
