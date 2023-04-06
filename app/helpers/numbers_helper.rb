module NumbersHelper
    def fraction_symbol(num)
        case(num)
        when 1/2r
            '½'
        when 1/3r
            '⅓'
        when 1/4r
            '¼'
        when 1/5r
            '⅕'
        when 1/6r
            '⅙'
        when 1/8r
            '⅛'
        when 2/3r
            '⅔'
        when 2/5r
            '⅖'
        when 3/8r
            '⅜'
        when 3/5r
            '⅗'
        when 4/5r
            '⅘'
        when 5/6r
            '⅚'
        when 5/8r
            '⅝'
        when 7/8r
            '⅞'
        when 1/7r
            '⅐'
        when 1/9r
            '⅑'
        when 1/10r
            '⅒'
        else
            num.to_s
        end
    end
end