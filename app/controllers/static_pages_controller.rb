class StaticPagesController < ApplicationController
  def home
    @departures_search = DeparturesSearch.new
  end

  def help
  end

  def about
  end

  def contact
  end
end
