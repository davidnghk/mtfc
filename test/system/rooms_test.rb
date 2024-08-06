require "application_system_test_case"

class RoomsTest < ApplicationSystemTestCase
  setup do
    @room = rooms(:one)
  end

  test "visiting the index" do
    visit rooms_url
    assert_selector "h1", text: "Rooms"
  end

  test "creating a Room" do
    visit rooms_url
    click_on "New Room"

    fill_in "Accomodate", with: @room.accomodate
    fill_in "Area", with: @room.area
    fill_in "Bath room", with: @room.bath_room
    fill_in "Bed type", with: @room.bed_type
    fill_in "Category", with: @room.category_id
    fill_in "Condition", with: @room.condition
    fill_in "Has air", with: @room.has_air
    fill_in "Has intenet", with: @room.has_intenet
    fill_in "Has kitchen", with: @room.has_kitchen
    fill_in "Location", with: @room.location_id
    fill_in "Status", with: @room.status
    fill_in "Tv", with: @room.tv
    click_on "Create Room"

    assert_text "Room was successfully created"
    click_on "Back"
  end

  test "updating a Room" do
    visit rooms_url
    click_on "Edit", match: :first

    fill_in "Accomodate", with: @room.accomodate
    fill_in "Area", with: @room.area
    fill_in "Bath room", with: @room.bath_room
    fill_in "Bed type", with: @room.bed_type
    fill_in "Category", with: @room.category_id
    fill_in "Condition", with: @room.condition
    fill_in "Has air", with: @room.has_air
    fill_in "Has intenet", with: @room.has_intenet
    fill_in "Has kitchen", with: @room.has_kitchen
    fill_in "Location", with: @room.location_id
    fill_in "Status", with: @room.status
    fill_in "Tv", with: @room.tv
    click_on "Update Room"

    assert_text "Room was successfully updated"
    click_on "Back"
  end

  test "destroying a Room" do
    visit rooms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Room was successfully destroyed"
  end
end
