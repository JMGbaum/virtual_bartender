require "test_helper"

class UserRecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_recipes_url
    assert_response :success
  end
end
