require 'rails_helper'

RSpec.feature "User navigates to product show page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )

    end

    scenario "Renders product page" do
      # ACT
      visit root_path
      body = page.find('.product')
      body.hover
      body.find('header a').click
      sleep 5
  
      # DEBUG
      #save_screenshot
  
      # VERIFY
      #puts page.html
      expect(page).to have_content 'Quantity'
  end
end