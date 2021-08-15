require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get users_edit_path
    assert_template 'users/edit'
    patch users_edit_path, params: { user: { email: "foo@invalid",
                                             password: "foo",
                                             password_confirmation: "bar" } }
    assert_template 'users/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get users_edit_path
    assert_template 'users/edit'
    email = "foo@bar.com"
    patch users_edit_path, params: {user: { email: email,
                                            password: "",
                                            password_confirmation: "",
                                            current_password: "password"} }
    assert_not flash.empty?
    assert_redirected_to root_url
    @user.reload
    assert_equal email, @user.email
  end
end
