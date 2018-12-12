class SearchFacade

  def initialize(data)
    @data = data
  end

  def stations
    data = service.get_stations
    data[:fuel_stations].map do |station|
      Station.new(station)
    end
  end

private

  def data
    @data
  end

  def service
    StationService.new(data)
  end

end
