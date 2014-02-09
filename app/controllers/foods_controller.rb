class FoodsController < ApplicationController
  def show
    @food = Food.find(params[:id])
    render json: @food, serializer: FoodSerializer
  end

  def index
    @foods = Food.limit(25)

    if params[:short_desc].present?
      @foods =
        @foods.where("upper(short_desc) LIKE ?", [params[:short_desc].upcase.gsub('%','') + '%'])
    end

    render json: @foods, each_serializer: FoodShortSerializer
  end
end
