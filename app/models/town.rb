class Town < ActiveRecord::Base
  before_validation :geocode_address
  validates :name, :latitude, :longitude, presence: true
  
  @@requested_weather
  
  private
    def geocode_address
      place = Nominatim.search(self.name).limit(1).address_details(true)
      if place && place.first
        current_town = place.first
        self.latitude = current_town.lat
        self.longitude = current_town.lon
      end
    end
  private
    def get_wheather
      wheather = ForecastIO::Forecast.new.coordinates(latitude: self.latitude, longitude: self.latitude)
      if wheather
        @@requested_weather = wheather
      end
    end
  def self.weather
    @@requested_weather
  end
end
