require 'rails_helper'

RSpec.feature "User navigates to product show page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    @category.products.create!(
      name:  "Click this one",
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 70.00
    )
  end

  scenario "Clicking on product navigates to show" do
    visit root_path

    page.find('.products .product:first-child a.btn').click

    # commented out b/c it's for debugging only
    save_and_open_screenshot

    expect(page).to have_css '.products-show'
  end
end