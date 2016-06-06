class DeparturesController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :edit, :update]
	respond_to :html, :json

	def index
		@departures = Departure.all
	end

	def show
		@departure = Departure.find(params[:id])
	end

	def new
		@departure = Departure.new
		@departure.start_address = Address.new
		@departure.end_address = Address.new
		respond_modal_with @departure
	end

	def create
		@departure = Departure.new(departure_params)
		@departure.user_id = session[:user_id]
		@departure.start_time = params[:departure][:start_time_date].gsub('/', '-') + ' ' + params[:departure][:start_time_time] + ' :00'
		@departure.start_address = Address.new(start_address_params)
		@departure.end_address = Address.new(end_address_params)

		if @departure.save
			redirect_to @departure
		else
			render 'new'
		end
	end

	private
		def departure_params
			params.require(:departure).permit(:passenger_capacity, :frequency, :price)
		end

		def start_address_params
			params.require(:departure).require(:address).permit(:line1, :line2, :city, :state, :zip)
		end

		def end_address_params
			params.require(:departure).require(:end_address).permit(:line1, :line2, :city, :state, :zip)
		end

		# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = 'Please log in.'
				redirect_to login_url
			end
		end
end