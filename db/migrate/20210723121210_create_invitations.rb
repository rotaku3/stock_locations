class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.references :group,null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true 
      t.integer :status , null: false, default: 0
      
      t.index [:group_id, :user_id], unique: true

      t.timestamps
    end
  end
end
