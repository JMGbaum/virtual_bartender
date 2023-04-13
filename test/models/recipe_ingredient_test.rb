require "test_helper"

class RecipeIngredientTest < ActiveSupport::TestCase
  setup do
    @recipe = Recipe.create(title: 'Aperol Spritz')
    @ingredient = Ingredient.create(name: 'Aperol', is_alcoholic: true)
    @recipe_ingredient = RecipeIngredient.new(mixable: @ingredient, recipe: @recipe, amount: 6, units: :centiliter)
  end

  test "should be valid" do
    assert @recipe_ingredient.valid?
  end

  test "should not be valid without recipe_id" do
    @recipe_ingredient.recipe_id = nil
    assert_not @recipe_ingredient.valid?
  end

  test "should not be valid without mixable_id" do
    @recipe_ingredient.mixable_id = nil
    assert_not @recipe_ingredient.valid?
  end

  test "#units_label should return an empty string if the units is nil" do
    @recipe_ingredient.units = nil
    assert_equal @recipe_ingredient.units_label, ''
  end

  test "#units_label should return the pluralized version of the unit" do
    assert_equal @recipe_ingredient.units_label, 'centiliters'
  end

  test '#units_label should return the custom unit if it is set to custom' do
    @recipe_ingredient.units = :custom
    @recipe_ingredient.custom_unit = 'bottle'
    assert_equal @recipe_ingredient.units_label, 'bottles'
  end

  test '#units_abbreviation should return a blank string if the units is nil' do
    @recipe_ingredient.units = nil
    assert_equal @recipe_ingredient.units_abbreviation, ''
  end

  test '#units_abbreviation should return the unit abbreviation' do
    assert_equal @recipe_ingredient.units_abbreviation, 'cl'
  end

  test '#units_abbreviation should return the custom unit if it is set to custom' do
    @recipe_ingredient.units = :custom
    @recipe_ingredient.custom_unit = 'bottle'
    assert_equal @recipe_ingredient.units_abbreviation, 'bottles'
  end

  test 'should get destroyed when recipe is destroyed' do
    assert @recipe_ingredient.save
    count = RecipeIngredient.count
    @recipe.destroy
    assert_equal RecipeIngredient.count, count - 1
  end

  test 'should get destroyed when ingredient is destroyed' do
    assert @recipe_ingredient.save
    count = RecipeIngredient.count
    @ingredient.destroy
    assert_equal RecipeIngredient.count, count - 1
  end

  test 'should incorporate polymorphism' do
    @tag = Tag.create(name: 'test')
    @recipe_ingredient.mixable = @tag
    assert @recipe_ingredient.valid?
    assert_equal @recipe_ingredient.mixable_type, 'Tag'
  end
end
