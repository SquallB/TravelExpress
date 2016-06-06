class DeparturesSearch < ActiveRecord::Base
  extend TimeSplitter::Accessors
  split_accessor :start_date

  def departures
    @departures ||= find_departures
  end

  private
    def find_departures
      Departure.all.find(:conditions => conditions)
    end

    def start_city_conditions
      ['start_address.city LIKE ?', "%#{start_city}%"] unless start_city.blank?
    end

    def end_city_conditions
      ['departures.end_address.city LIKE ?', "%#{end_city}%"] unless end_city.blank?
    end

    def conditions
      [conditions_clauses.join(' AND '), *conditions_options]
    end

    def conditions_clauses
      conditions_parts.map { |condition| condition.first }
    end

    def conditions_options
      conditions_parts.map { |condition| condition[1..-1] }.flatten
    end

    def conditions_parts
      private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
    end
end
