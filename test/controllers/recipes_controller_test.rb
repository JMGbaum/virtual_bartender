require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = Recipe.create(title: 'Aperol Spritz')
  end

  test "should get index" do
    get recipes_path
    assert_response :success
  end

  test "should get show" do
    get recipe_path(@recipe)
    assert_response :success
  end
end
