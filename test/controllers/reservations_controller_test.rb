require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:sufjan)
    @reservation = reservations(:sapporo)
  end
  
  test "should get index" do
    log_in_as(@user)
    get reservations_path
    assert_response :success
  end
  
  test "should get show" do
    log_in_as(@user)
    get reservation_path(@reservation)
    assert_match @reservation.room.name, response.body
    assert_match @reservation.start_date.to_s(:datekanji_jp), response.body
    assert_match @reservation.end_date.to_s(:datekanji_jp), response.body
    assert_match @reservation.total_price.to_s, response.body
  end
    
   test "should redirect index when not logged in" do
    get reservations_path
    assert_not flash.empty?
    assert_redirected_to users_sign_in_url
  end
  
  test "should redirect new when not logged in" do
    get new_reservation_path
    assert_not flash.empty?
    assert_redirected_to users_sign_in_url
  end
  
  test "should redirect create when not logged in" do
    post reservations_path
    assert_not flash.empty?
    assert_redirected_to users_sign_in_url
  end
  
  test "should redirect show when not logged in" do
    get reservation_path(@reservation)
    assert_not flash.empty?
    assert_redirected_to users_sign_in_url
  end
  
  test "should redirect show when logged in as wrong user" do
    log_in_as(@other_user)
    get reservation_path(@user.reservations.first)
    assert_not flash[:danger].empty?
    assert_redirected_to root_url
  end
end
