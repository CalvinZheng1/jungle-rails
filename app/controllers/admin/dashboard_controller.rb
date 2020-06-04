class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']
  def show
    @category_count = Category.all.count
    @product_count = Product.all.count
  end
end
