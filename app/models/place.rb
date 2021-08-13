class Place < ApplicationRecord
    after_validation :geocode, if: :address_changed?
    belongs_to :user
    
    geocoded_by :address
    
    
    validates :name,presence: true
    validates :user,presence: true
    validates :address,presence: true
    

end
