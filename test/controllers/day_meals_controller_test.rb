require "test_helper"

class DayMealsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get day_meals_index_url
    assert_response :success
  end
end
