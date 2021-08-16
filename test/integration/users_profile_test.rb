require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "unsuccessful profile edit" do
    log_in_as(@user)
    get users_profile_path
    assert_template 'users/profile'
    patch users_profile_path, params: { user: { name: "" } }
    assert_template 'users/profile'
  end
  
  test "successful profile edit" do
    log_in_as(@user)
    get users_profile_path
    assert_template 'users/profile'
    name = "Michael Test"
    introduction = "Introduction"
    image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    patch users_profile_path, params: {user: { name: name,
                                            introduction: introduction,
                                            image: image } }
    assert_not flash.empty?
    assert_redirected_to users_profile_url
    @user.reload
    assert_equal name, @user.name
    assert_equal introduction, @user.introduction
    assert @user.image.attached?
  end
end
