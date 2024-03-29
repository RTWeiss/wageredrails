class ImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
# before_action :correct_user, only: [:new, :create]

  def new 
    @image = Image.new
  end

  def create
    @image = Image.new(safe_image_params)
    @image.user_id = current_user.id
    @image.save
    
    if @image.persisted?
      flash[:notice] = "Image uploaded!"
      redirect_to "/"
    else
      flash[:notice] = "Image upload failed!"
      render :new
    end
  end

  private

  def safe_image_params
    params.require(:image).permit(:source)
  end
end
