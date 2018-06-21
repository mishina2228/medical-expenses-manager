require "application_system_test_case"

class TransportTest < ApplicationSystemTestCase
  setup do
    @transport = transports(:交通機関1)
  end

  test "visiting the index" do
    visit transport_url
    assert_selector "h1", text: "Transport"
  end

  test "creating a Transport" do
    visit transport_url
    click_on "New Transport"

    fill_in "Name", with: @transport.name
    click_on "Create Transport"

    assert_text "Transport was successfully created"
    click_on "Back"
  end

  test "updating a Transport" do
    visit transport_url
    click_on "Edit", match: :first

    fill_in "Name", with: @transport.name
    click_on "Update Transport"

    assert_text "Transport was successfully updated"
    click_on "Back"
  end

  test "destroying a Transport" do
    visit transport_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transport was successfully destroyed"
  end
end
