require "application_system_test_case"

class TransportationTest < ApplicationSystemTestCase
  setup do
    @transportation = transportation(:one)
  end

  test "visiting the index" do
    visit transportation_url
    assert_selector "h1", text: "Transportation"
  end

  test "creating a Transportation" do
    visit transportation_url
    click_on "New Transportation"

    fill_in "Name", with: @transportation.name
    click_on "Create Transportation"

    assert_text "Transportation was successfully created"
    click_on "Back"
  end

  test "updating a Transportation" do
    visit transportation_url
    click_on "Edit", match: :first

    fill_in "Name", with: @transportation.name
    click_on "Update Transportation"

    assert_text "Transportation was successfully updated"
    click_on "Back"
  end

  test "destroying a Transportation" do
    visit transportation_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transportation was successfully destroyed"
  end
end
