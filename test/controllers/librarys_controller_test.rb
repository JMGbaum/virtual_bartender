require "test_helper"

class LibrarysControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get librarys_new_url
    assert_response :success
  end
end
