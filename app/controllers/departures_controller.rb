class DeparturesController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :edit, :update, :book]
	respond_to :html, :json

	def index
		@departures = Departure.all
	end

	def show
		@departure = Departure.find(params[:id])
		@current_capacity = @departure.passenger_capacity
		departures_passengers = DeparturesPassengers.where(:departure_id => @departure.id)
		departures_passengers.each do |dp|
			@current_capacity -= dp.passengers_number
		end
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
		hour = params[:departure][:start_time_hour]
		if hour.length == 1
			hour = "0#{hour}"
		end
		min = params[:departure][:start_time_min]
		if min.length == 1
			min = "0#{min}"
		end
		@departure.start_time = "#{params[:departure][:start_time_date].gsub('/', '-')} #{hour}:#{min}:00"
		@departure.start_address = Address.new(start_address_params)
		@departure.end_address = Address.new(end_address_params)

		if @departure.save
			redirect_to @departure
		else
			render 'new'
		end
	end

  def search
		if params[:start_time_date]
			hour = params[:start_time_hour]
			if hour.length == 1
				hour = "0#{hour}"
			end
			min = params[:start_time_min]
			if min.length == 1
				min = "0#{min}"
			end
			start_time = "#{params[:start_time_date].gsub('/', '-')} #{hour}:#{min}:00"
		end
		results = Departure.search(params[:start_city], params[:end_city], start_time, params[:passengers])
		if results.any?
			@departures = results.all
		else
			@departures = []
		end
	end

  def book
		@departure = Departure.find(params[:id])
		passengers_number = params[:passengers_number].to_i
		current_capacity = @departure.passenger_capacity
		departures_passengers = DeparturesPassengers.where(:departure_id => @departure.id)
		departures_passengers.each do |dp|
			current_capacity -= dp.passengers_number
		end
		if (current_capacity - passengers_number) >= 0
			departures_passengers = DeparturesPassengers.new
			departures_passengers.departure_id = @departure.id
			departures_passengers.user_id = session[':user_id']
			departures_passengers.passengers_number = passengers_number

			if departures_passengers.save
				flash.now[:success] = 'Your travel is successfully booked'
			else
				flash.now[:danger] = 'Couldn\'t book the travel'
			end
		else
			flash.now[:danger] = 'Not enough seats in order to book the travel'
		end

		redirect_to @departure
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