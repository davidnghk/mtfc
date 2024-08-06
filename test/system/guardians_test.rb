require "application_system_test_case"

class GuardiansTest < ApplicationSystemTestCase
  setup do
    @guardian = guardians(:one)
  end

  test "visiting the index" do
    visit guardians_url
    assert_selector "h1", text: "Guardians"
  end

  test "creating a Guardian" do
    visit guardians_url
    click_on "New Guardian"

    fill_in "Email", with: @guardian.email
    fill_in "Guardian user", with: @guardian.guardian_user_id
    fill_in "Name", with: @guardian.name
    fill_in "Phone", with: @guardian.phone
    fill_in "User", with: @guardian.user_id
    click_on "Create Guardian"

    assert_text "Guardian was successfully created"
    click_on "Back"
  end

  test "updating a Guardian" do
    visit guardians_url
    click_on "Edit", match: :first

    fill_in "Email", with: @guardian.email
    fill_in "Guardian user", with: @guardian.guardian_user_id
    fill_in "Name", with: @guardian.name
    fill_in "Phone", with: @guardian.phone
    fill_in "User", with: @guardian.user_id
    click_on "Update Guardian"

    assert_text "Guardian was successfully updated"
    click_on "Back"
  end

  test "destroying a Guardian" do
    visit guardians_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Guardian was successfully destroyed"
  end
end
