class DeparturesController < ApplicationController
	def index
		@departures = Departure.all
	end

	def show
		@departure = Departure.find(params[:id])
	end

	def new
		@departure = Departure.new
	end

	def create
		@departure = Departure.new(departure_params)
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
			params.require(:departure).permit(:start_time, :user_id)
		end

		def start_address_params
			params.require(:departure).permit(:start_time, :user_id)
		end

		def departure_params
			params.require(:departure).permit(:start_time, :user_id)
		end
end