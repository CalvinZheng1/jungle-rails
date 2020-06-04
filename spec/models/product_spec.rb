require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.new(name: "New_Category")
      @product = Product.new(name: "basketball", price: 200, quantity: 12, category: @category)
    end

    it "should have a name" do
      @product.name = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "should have a price" do
      @product.price_cents = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
    end
    it "should have a quantity" do
      @product.quantity = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "should have a category" do
      @product.category = nil
      @product.valid?
      expect(@product.errors.full_messages).to include ("Category can't be blank")
    end
  end
end