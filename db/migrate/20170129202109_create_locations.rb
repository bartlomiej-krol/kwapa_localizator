class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.string :keywords

      t.timestamps null: false
    end
  end
end
