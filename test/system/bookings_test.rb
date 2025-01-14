require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase
  setup do
    @booking = bookings(:one)
  end

  test "visiting the index" do
    visit bookings_url
    assert_selector "h1", text: "Bookings"
  end

  test "creating a Booking" do
    visit bookings_url
    click_on "New Booking"

    fill_in "Checkin time", with: @booking.checkin_time
    fill_in "Checkout time", with: @booking.checkout_time
    fill_in "Client", with: @booking.client
    fill_in "End date", with: @booking.end_date
    fill_in "Location", with: @booking.location_id
    fill_in "Passport", with: @booking.passport
    fill_in "Start date", with: @booking.start_date
    click_on "Create Booking"

    assert_text "Booking was successfully created"
    click_on "Back"
  end

  test "updating a Booking" do
    visit bookings_url
    click_on "Edit", match: :first

    fill_in "Checkin time", with: @booking.checkin_time
    fill_in "Checkout time", with: @booking.checkout_time
    fill_in "Client", with: @booking.client
    fill_in "End date", with: @booking.end_date
    fill_in "Location", with: @booking.location_id
    fill_in "Passport", with: @booking.passport
    fill_in "Start date", with: @booking.start_date
    click_on "Update Booking"

    assert_text "Booking was successfully updated"
    click_on "Back"
  end

  test "destroying a Booking" do
    visit bookings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Booking was successfully destroyed"
  end
end
