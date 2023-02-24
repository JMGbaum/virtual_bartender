require "test_helper"

class IngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ingredients_path
    assert_response :success
  end
end
