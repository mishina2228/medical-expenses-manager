require "application_system_test_case"

class DrugstoresTest < ApplicationSystemTestCase
  setup do
    @drugstore = drugstores(:one)
  end

  test "visiting the index" do
    visit drugstores_url
    assert_selector "h1", text: "Drugstores"
  end

  test "creating a Drugstore" do
    visit drugstores_url
    click_on "New Drugstore"

    fill_in "Name", with: @drugstore.name
    click_on "Create Drugstore"

    assert_text "Drugstore was successfully created"
    click_on "Back"
  end

  test "updating a Drugstore" do
    visit drugstores_url
    click_on "Edit", match: :first

    fill_in "Name", with: @drugstore.name
    click_on "Update Drugstore"

    assert_text "Drugstore was successfully updated"
    click_on "Back"
  end

  test "destroying a Drugstore" do
    visit drugstores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Drugstore was successfully destroyed"
  end
end
