require "test_helper"

class RoomsShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @room = rooms(:sapporo)
  end
  
  test "unsuccessful new when attributes is nil" do
    log_in_as(@user)
    get room_path(@room)
    assert_template 'rooms/show'
    get new_reservation_path, params: { reservation: { start_date: nil,
                                                       end_date: nil,
                                                       person_num: nil,
                                                       room_id: @room.id } }
    assert_not flash.empty?
    assert_redirected_to room_url(@room)
  end
  
  test "unsuccessful new when start_date and end_date is past date" do
    log_in_as(@user)
    get room_path(@room)
    assert_template 'rooms/show'
    start_date = Date.today - 1
    end_date = Date.today - 1
    get new_reservation_path, params: { reservation: { start_date: start_date,
                                                       end_date: end_date,
                                                       person_num: 1,
                                                       room_id: @room.id } }
    assert_not flash.empty?
    assert_redirected_to room_url(@room)
  end
  
  test "unsuccessful new when person_num is invalid" do
    log_in_as(@user)
    get room_path(@room)
    assert_template 'rooms/show'
    start_date = Date.today
    end_date = Date.today + 1
    get new_reservation_path, params: { reservation: { start_date: start_date,
                                                       end_date: end_date,
                                                       person_num: -1,
                                                       room_id: @room.id } }
    assert_not flash.empty?
    assert_redirected_to room_url(@room)
  end
  
  test "successful new" do
    log_in_as(@user)
    get room_path(@room)
    assert_template 'rooms/show'
    start_date = Date.today
    end_date = Date.today + 1
    get new_reservation_path, params: { reservation: { start_date: start_date,
                                                       end_date: end_date,
                                                       person_num: 2,
                                                       room_id: @room.id } }
    assert flash.empty?
    assert_template 'reservations/new'
  end
end
