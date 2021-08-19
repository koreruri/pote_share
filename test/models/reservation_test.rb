require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @room = rooms(:sapporo)
    today = DateTime.now
    start_date = today
    end_date = start_date + 1
    @reservation = @room.reservations.build(start_date: start_date, end_date: end_date, person_num: 2, user_id: @user.id)
  end
  
  test "should be valid" do
    assert @reservation.valid?
  end
  
  test "user id should be present" do
    @reservation.user_id = nil
    assert_not @reservation.valid?
  end
  
  test "room id should be present" do
    @reservation.room_id = nil
    assert_not @reservation.valid?
  end
  
  test "start_date is should be present" do
    @reservation.start_date = ""
    assert_not @reservation.valid?
  end
  
  test "end_date is should be present" do
    @reservation.end_date = ""
    assert_not @reservation.valid?
  end

  test "person_num is should be present" do
    @reservation.person_num = ""
    assert_not @reservation.valid?
  end
  
  test "person_num should be numbers" do
    @reservation.person_num = "person_num"
    assert_not @reservation.valid?
  end
  
  test "person_num should be greater than 0" do
    @reservation.person_num = -1000
    assert_not @reservation.valid?
  end
  
  test "person_num should be integer" do
    @reservation.person_num = 1000.1
    assert_not @reservation.valid?
  end
  
end
