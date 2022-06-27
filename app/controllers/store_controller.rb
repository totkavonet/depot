class StoreController < ApplicationController
  before_action :session_counter, only: [ :index ]
  include CurrentCart
  before_action :set_cart

  def session_counter
    if $count_n.nil?
      $count_n = 1
    else
      $count_n += 1
    end

  end


  def index
    @products = Product.order(:title)
    @time = Time.new.strftime("%H:%M" )

  end

end
