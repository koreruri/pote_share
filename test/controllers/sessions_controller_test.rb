require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "should get new" do
    get users_sign_in_path
    assert_response :success
  end
  
  test "should redirect sign in when logged in" do
    log_in_as(@user)
    get users_sign_in_path
    assert_not flash[:danger].empty?
    assert_redirected_to root_url
  end
  
  test "should redirect log out when not logged in" do
    delete logout_path
    assert_not flash[:danger].empty?
    assert_redirected_to root_url
  end
end
