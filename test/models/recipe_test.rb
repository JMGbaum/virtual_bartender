require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  setup do
    @recipe = Recipe.new(title: 'Aperol Spritz')
  end

  test "should be valid" do
    assert @recipe.valid?
  end

  test "should not be invalid" do
    @recipe.title = " "
    assert_not @recipe.valid?
  end
end
