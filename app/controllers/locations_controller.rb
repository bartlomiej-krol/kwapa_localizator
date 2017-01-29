class LocationsController < ApplicationController
	before_filter :authorize_signed_in

	def index
	  	@user = User.find(current_user.id)
		@locations = @user.locations.order("name ASC")
	end

	def show
	  	@user = User.find(current_user.id)
		@location = @user.locations.find(params[:id])
	end

	def new
	end

	def create
	  @user = User.find(current_user.id)
	  @location = @user.locations.create(location_params)
	 
	  @location.save
	  redirect_to locations_path, notice: 'Pomyślnie dodano lokację!'
	end

	def edit
	  	@user = User.find(current_user.id)
		@location = @user.locations.find(params[:id])
	end

	def update
		@user = User.find(current_user.id)
		@location = @user.locations.find(params[:id])
	 
		if @location.update(location_params)
	  		redirect_to locations_path, notice: 'Pomyślnie zaktualizowano lokację!'
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(current_user.id)
		@location = @user.locations.find(params[:id])
	  	@location.destroy
	  	@user.save
	  	redirect_to locations_path, notice: 'Pomyślnie usunięto lokację!'
	end
	 
private
	def location_params
	    params.require(:location).permit(:name, :description, :latitude, :longitude, :keywords)
	end

	def authorize_signed_in
		return unless !user_signed_in?
		redirect_to root_path, alert: 'Musisz być zalogowany!'
	end
end