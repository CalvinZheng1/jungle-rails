class Admin::DashboardController < ApplicationController
  def show
    @category_count = Category.count
    @product_count = Product.count
  end
end
