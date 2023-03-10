require "test_helper"

class IngredientItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ingredient_items_new_url
    assert_response :success
  end
end
