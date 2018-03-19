require 'forecast_io'
ForecastIO.configure do |configuration|
  configuration.api_key = '64b1e08c3ffd70590bd6fd0aaaf320ff'
end

class Town < ActiveRecord::Base
  before_validation :geocode_address
  validates :name, :latitude, :longitude, presence: true
  

  private
    def geocode_address
      place = Nominatim.search(self.name).limit(1).address_details(true)
      if place && place.first
        current_town = place.first
        self.latitude = current_town.lat
        self.longitude = current_town.lon
      end
    end
  
  public
    def get_wheather
      wheather = ForecastIO.forecast(self.latitude, self.longitude, params: { units: 'si' })
      if wheather
        puts wheather
        return wheather
      end
    end
  
  def self.wheather
    wheather = ForecastIO.forecast(:latitude, :longitude)
    puts wheather
    return wheather
  end
end
