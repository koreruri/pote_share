require "test_helper"

class RoomsPostsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "rooms posts" do
    log_in_as(@user)
    get posts_rooms_path
    assert_template 'rooms/posts'
    rooms = assigns[:rooms]
    rooms.each do |room|
      assert_select 'a[href=?]', room_path(room), text: room.name
      assert_select 'td', text: room.introduction
      assert_select 'td', text: room.price.to_s
    end
  end
end
