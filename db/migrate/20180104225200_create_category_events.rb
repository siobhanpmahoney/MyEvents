class CreateCategoryEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :category_events do |t|
      t.belongs_to :category
      t.belongs_to :event

      t.timestamps
    end
  end
end
