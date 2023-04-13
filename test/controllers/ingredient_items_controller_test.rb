require "test_helper"

class IngredientItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ingredient_items_show_path
    assert_response :success
  end
end
