require 'rails_helper'

RSpec.feature "AddToCart", type: :feature, js: true do
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

    scenario "They see cart with item in it" do
      # ACT
      visit root_path
      body = page.find('.product')
      body.hover
      body.find('footer form button').click
      sleep 5
      # DEBUG
      save_screenshot
      # VERIFY
      #puts page.html
      expect(page).to have_text "My Cart (1)"

    end
end 