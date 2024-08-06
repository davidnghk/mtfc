require "application_system_test_case"

class OccupationsTest < ApplicationSystemTestCase
  setup do
    @occupation = occupations(:one)
  end

  test "visiting the index" do
    visit occupations_url
    assert_selector "h1", text: "Occupations"
  end

  test "creating a Occupation" do
    visit occupations_url
    click_on "New Occupation"

    fill_in "Checkin datetime", with: @occupation.checkin_datetime
    fill_in "Checkout datetime", with: @occupation.checkout_datetime
    fill_in "Customer", with: @occupation.customer
    fill_in "Due date", with: @occupation.due_date
    fill_in "Location", with: @occupation.location_id
    fill_in "Passport", with: @occupation.passport
    fill_in "Price", with: @occupation.price
    fill_in "Status", with: @occupation.status
    fill_in "Total", with: @occupation.total
    click_on "Create Occupation"

    assert_text "Occupation was successfully created"
    click_on "Back"
  end

  test "updating a Occupation" do
    visit occupations_url
    click_on "Edit", match: :first

    fill_in "Checkin datetime", with: @occupation.checkin_datetime
    fill_in "Checkout datetime", with: @occupation.checkout_datetime
    fill_in "Customer", with: @occupation.customer
    fill_in "Due date", with: @occupation.due_date
    fill_in "Location", with: @occupation.location_id
    fill_in "Passport", with: @occupation.passport
    fill_in "Price", with: @occupation.price
    fill_in "Status", with: @occupation.status
    fill_in "Total", with: @occupation.total
    click_on "Update Occupation"

    assert_text "Occupation was successfully updated"
    click_on "Back"
  end

  test "destroying a Occupation" do
    visit occupations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Occupation was successfully destroyed"
  end
end
