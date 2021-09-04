class User < ApplicationRecord
   validates :name, presence: true, length: { maximum: 10 },
                    uniqueness: { case_sensitive:true }
                    
   validates :password, presence: true, length: { minimum: 8 }
                     
    has_secure_password
    
    
    has_many :places
    
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    has_many :favorites
    has_many :favorite_places, through: :favorites, source: :place

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_places
    Place.where(user_id: self.following_ids + [self.id])
  end
  
  def favorite(fav_post)
        self.favorites.find_or_create_by(place_id: fav_post.id)
  end
  
  def unfavorite(fav_post)
        favorite = self.favorites.find_by(place_id: fav_post.id)
        favorite.destroy if favorite
  end
    
  def favorite?(fav_post)
        self.favorite_places.include?(fav_post)
  end
    
end
