class FoodsController < ApplicationController
  def show
    @food = Food.find(params[:id])
    render json: @food, serializer: FoodSerializer
  end

  def index
    @foods = Food.where("upper(short_desc) LIKE ?", [params[:short_desc].upcase.gsub('%','') + '%'])
      .limit(25)
    render json: @foods, each_serializer: FoodShortSerializer
  end
end
