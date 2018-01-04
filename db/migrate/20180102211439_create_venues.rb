class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :general_info
      t.string :parking_details
      t.string :tm_venue_id


      t.timestamps
    end
  end
end
