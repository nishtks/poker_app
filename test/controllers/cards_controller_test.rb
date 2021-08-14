require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get cards_top_url
    assert_response :success
  end

end
