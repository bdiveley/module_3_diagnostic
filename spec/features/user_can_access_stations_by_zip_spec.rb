require "rails_helper"

feature"user can search by zip code" do
  scenario "#80203 and get 10 sorted electric/propane stations within 6 miles" do
    # As a user
    # When I visit "/"
    visit root_path
    # And I fill in the search form with 80203 (Note: Use the existing search form)
    fill_in "q", with: "80203"
    # And I click "Locate"
    click_button "Locate"
    # Then I should be on page "/search"
    expect(current_path).to eq(search_path)
    # Then I should see a list of the 10 closest stations within 6 miles sorted by distance
    expect(page).to have_css(".station", count:10)

    within(".station") do
      #adjust this test later
      expect(page).not_to have_content("Distance: 10")
    # And the stations should be limited to Electric and Propane
      expect(page).to have_content("Fuel Types: Electric")
      expect(page).to have_content("Fuel Types: Propane")
      expect(page).not_to have_content("Fuel Types: Coal")
    # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
      expect(page).to have_content("Name:")
      expect(page).to have_content("Address:")
      expect(page).to have_content("Fuel Types:")
      expect(page).to have_content("Distance:")
      expect(page).to have_content("Access Times:")
    end
  end
end
