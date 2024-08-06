require "application_system_test_case"

class CallsTest < ApplicationSystemTestCase
  setup do
    @call = calls(:one)
  end

  test "visiting the index" do
    visit calls_url
    assert_selector "h1", text: "Calls"
  end

  test "creating a Call" do
    visit calls_url
    click_on "New Call"

    fill_in "Address", with: @call.address
    fill_in "Altitude", with: @call.altitude
    fill_in "Booking datetime", with: @call.booking_datetime
    fill_in "Latitude", with: @call.latitude
    fill_in "Longitude", with: @call.longitude
    fill_in "User", with: @call.user_id
    click_on "Create Call"

    assert_text "Call was successfully created"
    click_on "Back"
  end

  test "updating a Call" do
    visit calls_url
    click_on "Edit", match: :first

    fill_in "Address", with: @call.address
    fill_in "Altitude", with: @call.altitude
    fill_in "Booking datetime", with: @call.booking_datetime
    fill_in "Latitude", with: @call.latitude
    fill_in "Longitude", with: @call.longitude
    fill_in "User", with: @call.user_id
    click_on "Update Call"

    assert_text "Call was successfully updated"
    click_on "Back"
  end

  test "destroying a Call" do
    visit calls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Call was successfully destroyed"
  end
end
