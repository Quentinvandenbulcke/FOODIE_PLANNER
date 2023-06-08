require "test_helper"

class GroceriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get groceries_new_url
    assert_response :success
  end
end
