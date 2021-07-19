class User < ApplicationRecord
   validates :name, presence: true, length: { maximum: 25 },
                    uniqueness: { case_sensitive:true }
                    
   validates :password, length: { minimum: 8 }
                     
    has_secure_password
end
