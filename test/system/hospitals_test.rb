require "application_system_test_case"

class HospitalsTest < ApplicationSystemTestCase
  setup do
    @hospital = hospitals(:one)
  end

  test "visiting the index" do
    visit hospitals_url
    assert_selector "h1", text: "Hospitals"
  end

  test "creating a Hospital" do
    visit hospitals_url
    click_on "New Hospital"

    fill_in "Expense", with: @hospital.expense
    fill_in "Name", with: @hospital.name
    fill_in "Transportation", with: @hospital.transportation
    click_on "Create Hospital"

    assert_text "Hospital was successfully created"
    click_on "Back"
  end

  test "updating a Hospital" do
    visit hospitals_url
    click_on "Edit", match: :first

    fill_in "Expense", with: @hospital.expense
    fill_in "Name", with: @hospital.name
    fill_in "Transportation", with: @hospital.transportation
    click_on "Update Hospital"

    assert_text "Hospital was successfully updated"
    click_on "Back"
  end

  test "destroying a Hospital" do
    visit hospitals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Hospital was successfully destroyed"
  end
end
