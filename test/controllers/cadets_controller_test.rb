require 'test_helper'

class CadetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cadets_new_url
    assert_response :success
  end

end
