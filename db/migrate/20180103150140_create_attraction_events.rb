class CreateAttractionEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :attraction_events do |t|
      t.belongs_to :event, foreign_key: true
      t.belongs_to :attraction, foreign_key: true

      t.timestamps
    end
  end
end
