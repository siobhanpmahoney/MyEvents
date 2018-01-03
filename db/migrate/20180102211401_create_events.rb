class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :sale_date
      t.datetime :start_date
      t.belongs_to :venue, foreign_key: true

      t.timestamps
    end
  end
end
