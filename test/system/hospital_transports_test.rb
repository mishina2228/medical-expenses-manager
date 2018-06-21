require "application_system_test_case"

class HospitalTransportsTest < ApplicationSystemTestCase
  setup do
    @hospital_transport = hospital_transports(:病院交通費1)
  end

  test "visiting the index" do
    visit hospital_transports_url
    assert_selector "h1", text: "Hospital Transports"
  end

  test "creating a Hospital transport" do
    visit hospital_transports_url
    click_on "New Hospital Transport"

    click_on "Create Hospital transport"

    assert_text "Hospital transport was successfully created"
    click_on "Back"
  end

  test "updating a Hospital transport" do
    visit hospital_transports_url
    click_on "Edit", match: :first

    click_on "Update Hospital transport"

    assert_text "Hospital transport was successfully updated"
    click_on "Back"
  end

  test "destroying a Hospital transport" do
    visit hospital_transports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Hospital transport was successfully destroyed"
  end
end
