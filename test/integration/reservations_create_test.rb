require "test_helper"

class ReservationsCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @room = rooms(:sapporo)
  end
  
  test "successful reservation create" do
    log_in_as(@user)
    start_date = Date.today
    end_date = Date.today + 1
    assert_difference 'Reservation.count', 1 do
      post reservations_path, params: { reservation: { room_id: @room.id,
                                                       start_date: start_date,
                                                       end_date: end_date,
                                                       person_num: 2,
                                                       total_price: 12000} }
    end
    assert_not flash.empty?
    reservation = assigns(:reservation)
    assert_redirected_to reservation
  end
  
  test "unsuccessful reservation create" do
    log_in_as(@user)
    start_date = Date.today
    end_date = Date.today + 1
    assert_no_difference 'Reservation.count' do
      post reservations_path, params: { reservation: { room_id: @room.id,
                                                       start_date: start_date,
                                                       end_date: end_date,
                                                       person_num: nil,
                                                       total_price: nil} }
    end
    assert_not flash.empty?
    assert_redirected_to room_url(@room)
  end
  
end
