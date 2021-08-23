require "test_helper"

class RoomsCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
   test "unsuccessful room create" do
    log_in_as(@user)
    get new_room_path
    assert_template 'rooms/new'
    assert_no_difference 'Room.count' do
      post rooms_path, params: { room: { name: "",
                                         introduction: "",
                                         price: "",
                                         address: "" } }
    end
    assert_template 'rooms/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "successful room create with friendry forwarding" do
    get new_room_path
    log_in_as(@user)
    assert_redirected_to rooms_new_url
    name = "Nice room"
    introduction = "Introduction"
    price = 5000
    address = "Tokyo"
    image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: name,
                                         introduction: introduction,
                                         price: price,
                                         address: address,
                                         image: image } }
    end
    assert_not flash.empty?
    room = assigns(:room)
    assert_redirected_to room
  end
end
