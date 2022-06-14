class StoreController < ApplicationController

  def index
    @products = Product.order(:title)
    @time = Time.new.strftime("%H:%M" )

  end
end
