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
			params.require(:departure).permit(:start_line_1, :start_line_2, :start_city, :start_state, :start_zip)
		end

		def end_address_params
			params.require(:departure).permit(:end_line_1, :end_line_2, :end_city, :end_state, :end_zip)
		end
end