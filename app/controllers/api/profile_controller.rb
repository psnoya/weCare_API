class Api::ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :find_resource
  
  def show
    render json: @user_profile
  end

  def update
      @user_profile[:image] = attach_image(@user_profile)
      @user_profile.update(user_profile_params)
      @user_profile.save
    else
      render json: { message: 'wrong wrong wrong' }
    end
  end

  private

  def attach_image(user_profile_params)
    params_image = params[:image]
    DecodeService.attach_image(params_image, @user_profile.image) if params_image.present?
  end

  def user_profile_params
    params.permit(:image)
  end

  def find_resource
    @user_profile = User.find(params[:id])
  end
end




end
