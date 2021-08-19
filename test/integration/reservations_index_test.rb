require "test_helper"

class ReservationsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "reservations index" do
    log_in_as(@user)
    get reservations_path
    assert_template 'reservations/index'
    reservations = assigns[:reservations]
    reservations.each do |reservation|
      assert_select 'a[href=?]', room_path(reservation.room), text: reservation.room.name
      assert_select 'td', text: reservation.room.introduction
      total_price = reservation.person_num * reservation.room.price
      assert_select 'td', text: total_price.to_s
    end
  end
end
