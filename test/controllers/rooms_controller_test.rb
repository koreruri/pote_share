require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @room = rooms(:sapporo)
  end
  
  test "should redirect new when not logged in" do
    get new_room_path
    assert_redirected_to users_sign_in_path
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Room.count' do
      post rooms_path, params: { rooms: { name: "テスト部屋",
                                          introduction: "駅近です！",
                                          price: 5000,
                                          address: "東京都新宿区" } }
    end
    assert_redirected_to users_sign_in_path
  end
end
