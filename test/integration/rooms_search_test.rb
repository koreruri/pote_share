require "test_helper"

class RoomsSearchTest < ActionDispatch::IntegrationTest

  test "rooms search by area" do
    get search_rooms_path, params: {area: "北海道"}
    assert_template 'rooms/search'
    results = assigns(:results)
    assert_match results.count.to_s, response.body
    results.each do |result|
      assert_match result.name, response.body
      assert_match result.address, response.body
      assert_match result.price.to_s, response.body
    end
  end

  test "rooms search by keyword" do
    get search_rooms_path, params: {keyword: "！"}
    assert_template 'rooms/search'
    results = assigns(:results)
    assert_match results.count.to_s, response.body
    results.each do |result|
      assert_match result.name, response.body
      assert_match result.address, response.body
      assert_match result.price.to_s, response.body
    end
  end
  
  
end
