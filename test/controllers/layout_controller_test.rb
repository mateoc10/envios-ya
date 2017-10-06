require 'test_helper'

class LayoutControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get layout_home_url
    assert_response :success
  end

end
