require "test_helper"

class DecksControllerTest < ActionDispatch::IntegrationTest
  test "should get choose" do
    get decks_choose_url
    assert_response :success
  end
end
