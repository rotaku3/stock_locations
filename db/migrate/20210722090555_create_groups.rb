class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true
      t.boolean :public, default: false, null: false
      t.timestamps
    end
  end
end
