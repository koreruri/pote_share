require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reservations_path
    assert_response :success
  end

  test "should get new" do
    get new_reservation_path
    assert_response :success
  end
end
