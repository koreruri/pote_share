require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @room = rooms(:sapporo)
  end
  
  test "should get index" do
    log_in_as(@user)
    get reservations_path
    assert_response :success
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
  
  test "should redirect update when not logged in" do
    post reservations_path
    assert_not flash.empty?
    assert_redirected_to users_sign_in_url
  end
end
