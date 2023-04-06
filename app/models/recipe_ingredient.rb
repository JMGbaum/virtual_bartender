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

    def amount_as_mixed_number
        parts = amount.to_r.divmod(1)
        whole = parts[0].zero? ? '' : parts[0]
        fraction = parts[1].zero? ? '' : fraction_symbol(parts[1])

        "#{whole} #{fraction}".squish
    end

    def amount_label
        return 'to taste' if amount.nil? && units.nil?

        "#{amount_as_mixed_number} #{units_abbreviation}"
    end

    def pluralize_units(str)
        return str if amount < 1
        
        str.pluralize(amount)
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
            pluralize_units('pt')
        when /^quart$/
            pluralize_units('qt')
        when /^gallon$/
            pluralize_units('gal')
        when /^custom$/
            amount.nil? ? custom_unit : pluralize_units(custom_unit)
        else
            pluralize_units(units)
        end
    end

    # Returns the custom unit or the full unit name
    def units_label
        return '' if units.nil?
        return amount.nil? ? custom_unit : pluralize_units(custom_unit) if custom_units?

        pluralize_units(units)
    end
end
