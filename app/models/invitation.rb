class Invitation < ApplicationRecord
    belongs_to :user
    belongs_to :group
    enum status: { inviting: 0, participated: 1}
end
