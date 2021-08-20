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
    reservation = assigns(:reservation)
    days_of_use = assigns(:days_of_use)
    total_price = assigns(:total_price)
    assert_select 'input[name=?]', 'reservation[start_date]', value: reservation.start_date.to_s(:date_jp)
    assert_select 'input[name=?]', 'reservation[end_date]', value: reservation.end_date.to_s(:date_jp)
    assert_match "使用日数 : #{days_of_use.to_s}日", response.body
    assert_match "人数 : #{reservation.person_num}人", response.body
    assert_select 'input[name=?]', 'reservation[total_price]', value: total_price
  end
end
