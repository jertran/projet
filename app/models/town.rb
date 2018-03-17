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

end
