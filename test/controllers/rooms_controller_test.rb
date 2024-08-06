require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = rooms(:one)
  end

  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_room_url
    assert_response :success
  end

  test "should create room" do
    assert_difference('Room.count') do
      post rooms_url, params: { room: { accomodate: @room.accomodate, area: @room.area, bath_room: @room.bath_room, bed_type: @room.bed_type, category_id: @room.category_id, condition: @room.condition, has_air: @room.has_air, has_intenet: @room.has_intenet, has_kitchen: @room.has_kitchen, location_id: @room.location_id, status: @room.status, tv: @room.tv } }
    end

    assert_redirected_to room_url(Room.last)
  end

  test "should show room" do
    get room_url(@room)
    assert_response :success
  end

  test "should get edit" do
    get edit_room_url(@room)
    assert_response :success
  end

  test "should update room" do
    patch room_url(@room), params: { room: { accomodate: @room.accomodate, area: @room.area, bath_room: @room.bath_room, bed_type: @room.bed_type, category_id: @room.category_id, condition: @room.condition, has_air: @room.has_air, has_intenet: @room.has_intenet, has_kitchen: @room.has_kitchen, location_id: @room.location_id, status: @room.status, tv: @room.tv } }
    assert_redirected_to room_url(@room)
  end

  test "should destroy room" do
    assert_difference('Room.count', -1) do
      delete room_url(@room)
    end

    assert_redirected_to rooms_url
  end
end
