require "test_helper"

class RoomTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    #このコードは慣習的に正しくない
    @room = Room.new(name: "test room", introduction: "Lorem ipsum", price: 5000, address: "東京都新宿区", user_id: @user.id)
  end
  
  test "should be valid" do
    assert @room.valid?
  end
  
  test "user id should be present" do
    @room.user_id = nil
    assert_not @room.valid?
  end
  
  test "name should be present" do
    @room.name = ""
    assert_not @room.valid?
  end
  
  test "introduction should be present" do
    @room.introduction = ""
    assert_not @room.valid?
  end
  
  test "price should be present" do
    @room.price = ""
    assert_not @room.valid?
  end
  
  test "price should be numbers" do
    @room.price = "price"
    assert_not @room.valid?
  end
  
  test "price should be greater than 0" do
    @room.price = -1000
    assert_not @room.valid?
  end
  
  test "price should be integer" do
    @room.price = 1000.1
    assert_not @room.valid?
  end
  
  test "address should be present" do
    @room.address=""
    assert_not @room.valid?
  end
end
