class StationService

  def initialize(filter)
    @filter = filter
  end

  def get_stations
    get_json("/api/alt-fuel-stations/v1/nearest.json?radius=6&fuel_type=ELEC,LPG&location=#{filter}&limit=10")
  end

private

  def filter
    @filter
  end
  
  def conn
    Faraday.new(:url => 'https://developer.nrel.gov') do |faraday|
      faraday.headers['X-Api-Key'] = ENV['nrel_key']
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    data = JSON.parse(response.body, symbolize_names: true)
  end

end
