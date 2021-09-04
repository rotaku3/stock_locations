class Place < ApplicationRecord
    after_validation :geocode, if: :address_changed?
    belongs_to :user
    has_many :favorites, dependent: :destroy
    
    geocoded_by :address
    
    mount_uploader :image, ImageUploader
    
    
    validates :name,presence: true
    validates :address,presence: true
    
    
    

end
