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
end
