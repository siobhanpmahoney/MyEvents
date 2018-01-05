class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :event, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
