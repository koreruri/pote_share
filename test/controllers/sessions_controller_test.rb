require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_sign_in_path
    assert_response :success
  end
end
