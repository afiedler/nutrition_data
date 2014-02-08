class FoodsController < ApplicationController
  def show
    @food = Food.find(params[:id])
    render json: @food, serializer: FoodSerializer
  end

  def list
    @foods = Food.where("upper(short_desc) LIKE '?%'", [params[:short_desc].upcase])
    render json: @foods, serializer: FoodShortSerializer
  end
end
