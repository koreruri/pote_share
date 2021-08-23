require "test_helper"

class RoomsPostsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "rooms posts with friendry forwading" do
    get posts_rooms_path
    log_in_as(@user)
    assert_redirected_to posts_rooms_url
    follow_redirect!
    rooms = assigns[:rooms]
    rooms.each do |room|
      assert_select 'a[href=?]', room_path(room), text: room.name
      assert_select 'td', text: room.introduction
      assert_select 'td', text: room.price.to_s
    end
  end
end
