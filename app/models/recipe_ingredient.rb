class RecipeIngredient < ApplicationRecord
    belongs_to :recipe, inverse_of: :recipe_ingredients
    belongs_to :mixable, polymorphic: true, inverse_of: :recipe_ingredients

    validates :recipe_id, presence: true
    validates :mixable_type, presence: true
    validates :mixable_id, presence: true

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
    }, _suffix: true

    def amount_label
        return 'to taste' if amount.nil? && units.nil?

        "#{amount} #{units_abbreviation}"
    end

    # Returns the units abbreviation if there is one
    def units_abbreviation
        case units
        when nil
            ''
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
            amount.nil? ? custom_unit : custom_unit.pluralize(amount)
        else
            units.pluralize(amount)
        end
    end

    # Returns the custom unit or the full unit name
    def units_label
        return '' if units.nil?
        return amount.nil? ? custom_unit : custom_unit.pluralize(amount) if custom_units?

        units.pluralize(amount)
    end
end
