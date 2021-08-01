class Place < ApplicationRecord
    after_validation :geocode, if: :address_changed?
    belongs_to :user
    
    geocoded_by :address
    
    
    validates :name,presence: true
    validates :user,presence: true
    validates :address,presence: true
    
private
  def geocode
    uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=<%= ENV['GOOGLEMAP'] %>")
    res = HTTP.get(uri).to_s
    response = JSON.parse(res)
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end
