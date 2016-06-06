class DeparturesSearchController < ApplicationController
  def index
    @departures_search = DeparturesSearch.new
  end

  def show
    @departures_search = DeparturesSearch.find(params[:id])
  end

  def create
    @departures_search = DeparturesSearch.new(departures_search_params)
    @departures_search.departures

    if @departures_search.save
      redirect_to @departures_search
    else
      render 'new'
    end
  end

  private
    def departures_search_params
      params.require(:departures_search).permit(:start_city, :end_city, :start_date, :passengers)
    end
end
