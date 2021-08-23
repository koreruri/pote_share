require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "login with valid email/invalid password" do
    get users_sign_in_path
    post users_sign_in_path, params: { session: { email: @user.email,
                                password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do
    get users_sign_in_path
    post users_sign_in_path, params: { session: { email: @user.email,
                                password: 'password' } }
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select "a[href=?]", users_sign_in_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_account_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", users_sign_in_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", users_account_path, count: 0
  end
  
  test "login with invalid information" do
    get users_sign_in_path
    assert_template 'sessions/new'
    post users_sign_in_path, params: { session: { email: "", password: "" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
