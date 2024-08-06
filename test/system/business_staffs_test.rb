require "application_system_test_case"

class BusinessStaffsTest < ApplicationSystemTestCase
  setup do
    @business_staff = business_staffs(:one)
  end

  test "visiting the index" do
    visit business_staffs_url
    assert_selector "h1", text: "Business Staffs"
  end

  test "creating a Business staff" do
    visit business_staffs_url
    click_on "New Business Staff"

    fill_in "Business unit", with: @business_staff.business_unit_id
    fill_in "Post", with: @business_staff.post_id
    fill_in "User", with: @business_staff.user_id
    click_on "Create Business staff"

    assert_text "Business staff was successfully created"
    click_on "Back"
  end

  test "updating a Business staff" do
    visit business_staffs_url
    click_on "Edit", match: :first

    fill_in "Business unit", with: @business_staff.business_unit_id
    fill_in "Post", with: @business_staff.post_id
    fill_in "User", with: @business_staff.user_id
    click_on "Update Business staff"

    assert_text "Business staff was successfully updated"
    click_on "Back"
  end

  test "destroying a Business staff" do
    visit business_staffs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Business staff was successfully destroyed"
  end
end
