class ImagesController < ApplicationController
	before_action :logged_in_user, only: [:new, :create]
#	before_action :correct_user, only: [:new, :create]

	def new 
		@image = Image.new
	end

	def create 
		@image = current_user.images.create(safe_image_params)
		if @picture.persisted?
			flash[:notice] = "Image uploaded!"
			redirect_to @user 
		else
			render :new
		end
	end

	private 

	def safe_image_params
		params.require(:image).permit(:source)
	end

	def current_user
    if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
			  @current_user = user
			end
		end
	end

	def logged_in_user
    unless logged_in?
    	store_location
    	flash[:danger] = "Please log in."
    	redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
