class CreateRealEstates < ActiveRecord::Migration[5.1]
  def change
    create_table :real_estates do |t|
      t.string :street
      t.string :city
      t.string :zip
      t.string :state
      t.integer :beds
      t.integer :baths
      t.integer :sq_ft
      t.integer :building_type, default: 0
      t.datetime :sale_date
      t.decimal :price
      t.float :latitude
      t.float :longitude

      t.timestamps

      t.index :building_type
      t.index :price
      t.index :sq_ft
    end
  end
end
