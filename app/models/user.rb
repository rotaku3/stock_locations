class User < ApplicationRecord
   validates :name, presence: true, length: { maximum: 25 },
                    uniqueness: { case_sensitive:true }
                    
   validates :password, length: { minimum: 8 }
                     
    has_secure_password
    
    has_many :places
    has_many :groups,dependent: :destroy

    
    has_many :invitations,dependent: :destroy
    has_many :invitation_groups, through: :invitations, source: :group
    
    def participated_groups
      invitations = self.invitations.where(status: 'participated')
      ids = invitations.pluck(:group_id)
      Group.where(id: ids)
    end
    
    def inviting_groups
      invitations = self.invitations.where(status: 'inviting')
      ids = invitations.pluck(:group_id)
      Group.where(id: ids)
    end
    
    def invitation(other_user)
     unless self == other_user && other_user.id == invitations.user_id
      self.invitations.find_or_create_by(user_id: other_user.id)
     end
    end
    
    def invitation?(other_user)
     self.invitations.include?(other_user)
    end
    
end
