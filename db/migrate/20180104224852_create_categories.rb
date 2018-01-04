class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :subgenre_name
      t.string :subgenre_tm_id
      t.string :genre_name
      t.string :genre_tm_id
      t.string :classification_name
      t.string :classification_tm_id

      t.timestamps
    end
  end
end
