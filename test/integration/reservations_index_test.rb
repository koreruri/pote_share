require "test_helper"

class ReservationsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "reservations index with friendly forwarding" do
    get reservations_path
    log_in_as(@user)
    # assert_template 'reservations/index'
    assert_redirected_to reservations_url
    follow_redirect!
    reservations = assigns[:reservations]
    reservations.each do |reservation|
      assert_select 'a[href=?]', room_path(reservation.room), text: reservation.room.name
      assert_select 'td', text: reservation.room.introduction
      total_price = reservation.person_num * reservation.room.price
      assert_select 'td', text: total_price.to_s
    end
  end
end
