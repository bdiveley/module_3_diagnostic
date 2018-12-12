class SearchFacade

  def initialize(data)
    @data = data
  end

  def stations
    #this should return an array of station objects
    conn = Faraday.new(:url => 'https://developer.nrel.gov') do |faraday|
      faraday.headers['X-Api-Key'] = ENV['nrel_key']
      faraday.adapter Faraday.default_adapter
    end
    response = conn.get("/api/alt-fuel-stations/v1/nearest.json?radius=6&fuel_type=ELEC,LPG&location=#{@data}&limit=10")
    data = JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end

end
