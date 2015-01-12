class RenameColumnToEvents < ActiveRecord::Migration
  def change
		rename_column :events, :place, :spot
  end
end
