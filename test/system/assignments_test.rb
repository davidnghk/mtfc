require "application_system_test_case"

class AssignmentsTest < ApplicationSystemTestCase
  setup do
    @assignment = assignments(:one)
  end

  test "visiting the index" do
    visit assignments_url
    assert_selector "h1", text: "Assignments"
  end

  test "creating a Assignment" do
    visit assignments_url
    click_on "New Assignment"

    fill_in "Due datetime", with: @assignment.due_datetime
    fill_in "End datetime", with: @assignment.end_datetime
    fill_in "Heading", with: @assignment.heading
    fill_in "Incharge user", with: @assignment.incharge_user_id
    fill_in "Location", with: @assignment.location_id
    fill_in "Start datetime", with: @assignment.start_datetime
    fill_in "Status", with: @assignment.status
    fill_in "Work", with: @assignment.work_id
    click_on "Create Assignment"

    assert_text "Assignment was successfully created"
    click_on "Back"
  end

  test "updating a Assignment" do
    visit assignments_url
    click_on "Edit", match: :first

    fill_in "Due datetime", with: @assignment.due_datetime
    fill_in "End datetime", with: @assignment.end_datetime
    fill_in "Heading", with: @assignment.heading
    fill_in "Incharge user", with: @assignment.incharge_user_id
    fill_in "Location", with: @assignment.location_id
    fill_in "Start datetime", with: @assignment.start_datetime
    fill_in "Status", with: @assignment.status
    fill_in "Work", with: @assignment.work_id
    click_on "Update Assignment"

    assert_text "Assignment was successfully updated"
    click_on "Back"
  end

  test "destroying a Assignment" do
    visit assignments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Assignment was successfully destroyed"
  end
end
