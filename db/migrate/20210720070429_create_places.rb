class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.string :content
      t.datetime :datetime

      t.timestamps
    end
  end
end
