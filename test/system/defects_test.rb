require "application_system_test_case"

class DefectsTest < ApplicationSystemTestCase
  setup do
    @defect = defects(:one)
  end

  test "visiting the index" do
    visit defects_url
    assert_selector "h1", text: "Defects"
  end

  test "creating a Defect" do
    visit defects_url
    click_on "New Defect"

    fill_in "Assignment", with: @defect.assignment_id
    fill_in "Defect", with: @defect.defect_id
    fill_in "Rating", with: @defect.rating
    fill_in "Remarks", with: @defect.remarks
    click_on "Create Defect"

    assert_text "Defect was successfully created"
    click_on "Back"
  end

  test "updating a Defect" do
    visit defects_url
    click_on "Edit", match: :first

    fill_in "Assignment", with: @defect.assignment_id
    fill_in "Defect", with: @defect.defect_id
    fill_in "Rating", with: @defect.rating
    fill_in "Remarks", with: @defect.remarks
    click_on "Update Defect"

    assert_text "Defect was successfully updated"
    click_on "Back"
  end

  test "destroying a Defect" do
    visit defects_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Defect was successfully destroyed"
  end
end
