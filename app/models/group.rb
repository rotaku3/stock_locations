class Group < ApplicationRecord
    belongs_to :user
    
    has_many :invitations,dependent: :destroy
    has_many :invitation_users, through: :invitations, source: :user
    
    def participated_users
        invitations = self.invitations.where(status: 'participated')
        ids = invitations.pluck(:user_id)
        User.where(id: ids)
    end
    
    def inviting_users
        invitations = self.invitations.where(status: 'inviting')
        ids = invitations.pluck(:user_id)
        User.where(id: ids)
    end
    
    
    validates :name, presence: true
    
    #after_save do |group|
       # group.user.invitations.create!(group_id: group.id, status: 'participated')
    #end
end
