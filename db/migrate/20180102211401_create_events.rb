class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :sale_start_date
      t.datetime :sale_end_date
      t.datetime :start_date
      t.float :price_min
      t.float :price_max
      t.string :image_1
      t.string :tm_url
      t.string :tm_event_id
      t.belongs_to :venue, foreign_key: true

      t.timestamps
    end
  end
end
