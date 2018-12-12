require "rails_helper"

feature"user can search by zip code" do
  scenario "#80203 and get 10 sorted electric/propane stations within 6 miles" do
    visit root_path

    fill_in "q", with: "80203"

    click_button "Locate"

    expect(current_path).to eq(search_path)
    # Then I should see a list of the 10 closest stations within 6 miles sorted by distance
    expect(page).to have_css(".station", count:10)

    within(first(".station")) do
      expect(page).to be <= 10

    # And the stations should be limited to Electric and Propane
      expect(page).to have_content("Fuel Types: ELEC")
      expect(page).to have_content("Fuel Types: LPG")

    # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
      expect(page).to have_content("Name:")
      expect(page).to have_content("Address:")
      expect(page).to have_content("Fuel Types:")
      expect(page).to have_content("Distance:")
      expect(page).to have_content("Access Times:")
    end
  end
end
