class Api::FoodbagsController < ApplicationController
  before_action :authenticate_user!

  def create
    foodbag = Foodbag.create(pickuptime: params['foodbag']['pickuptime'], donor_id: current_user.id)
    if foodbag.persisted?
      render json: { message: 'Your foodbag was successfully created!' }, status: 201
    else
      render json: { message: foodbag.errors.full_messages.to_sentence }, status: 422
    end
  end

  def index
    foodbags = Foodbag.all.order('created_at DESC')
    render json: foodbags, each_serializer: FoodbagsIndexSerializerSerializer
  end

  def update
    foodbag = Foodbag.find(params['id'])
    foodbag.update(status: params['foodbag']['status'], recipient_id: current_user.id)
    if foodbag.save
      render json: { message: 'Your foodbag is reserved!' }
    else
      render json: { message: foodbag.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def set_foodbag
    foodbag = Foodbag.find(params[:id])
  end

  def foodbag_params
    params.reqiore(:foodbag).permit(:word)
  end
end
