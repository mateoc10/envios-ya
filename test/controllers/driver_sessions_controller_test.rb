require 'test_helper'

class DriverSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get driver_sessions_new_url
    assert_response :success
  end

end
