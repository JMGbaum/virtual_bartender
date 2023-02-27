require "test_helper"

class RecipeIngredientTest < ActiveSupport::TestCase
  setup do
    @recipe = Recipe.create(title: 'Aperol Spritz')
    @ingredient = Ingredient.create(name: 'Aperol', is_alcoholic: true)
    @recipe_ingredient = RecipeIngredient.new(ingredient_id: @ingredient.id, recipe_id: @recipe.id, amount: 6, units: :centiliter)
  end

  test "should be valid" do
    assert @recipe_ingredient.valid?
  end

  test "should not be valid without recipe_id" do
    @recipe_ingredient.recipe_id = nil
    assert_not @recipe_ingredient.valid?
  end

  test "should not be valid without ingredient_id" do
    @recipe_ingredient.ingredient_id = nil
    assert_not @recipe_ingredient.valid?
  end

  test "should not be valid without amount" do
    @recipe_ingredient.amount = nil
    assert_not @recipe_ingredient.valid?
  end

  test "should not be valid without units" do
    @recipe_ingredient.units = nil
    assert_not @recipe_ingredient.valid?
  end

  test "#units_label should return the pluralized version of the unit" do
    assert_equal @recipe_ingredient.units_label, 'centiliters'
  end

  test '#units_label should return the custom unit if it is set to custom' do
    @recipe_ingredient.units = :custom
    @recipe_ingredient.custom_unit = 'bottle'
    assert_equal @recipe_ingredient.units_label, 'bottles'
  end

  test '#units_abbreviation should return the unit abbreviation' do
    assert_equal @recipe_ingredient.units_abbreviation, 'cl'
  end

  test '#units_abbreviation should return the custom unit if it is set to custom' do
    @recipe_ingredient.units = :custom
    @recipe_ingredient.custom_unit = 'bottle'
    assert_equal @recipe_ingredient.units_abbreviation, 'bottles'
  end
end
