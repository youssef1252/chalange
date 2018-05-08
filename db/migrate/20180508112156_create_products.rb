class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :libelle
      t.decimal :price
      t.string :image
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
