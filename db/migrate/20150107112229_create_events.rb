class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :place_id
      t.string :spot
      t.string :name
      t.datetime :start_date
      t.integer :participants
      t.integer :unoccupied_seats

      t.timestamps
    end
    add_index :events
  end
end
