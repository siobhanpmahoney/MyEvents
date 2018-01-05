class CreateAttractions < ActiveRecord::Migration[5.1]
  def change
    create_table :attractions do |t|
      t.string :name
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :youtube

      t.string :tm_attraction_id

      t.timestamps
    end
  end
end
