require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "should get new" do
    get users_sign_up_path
    assert_response :success
  end
  
  test "should redirect show when not logged in" do
    get users_account_path
    assert_not flash.empty?
    assert_redirected_to users_sign_in_url
  end
  
  test "should redirect edit when not logged in" do
    get users_edit_path
    assert_not flash.empty?
    assert_redirected_to users_sign_in_url
  end
  
  test "should redirect update when not logged in" do
    patch users_edit_path, params: { user: { email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to users_sign_in_url
  end
end
