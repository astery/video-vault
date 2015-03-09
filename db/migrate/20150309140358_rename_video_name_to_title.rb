class RenameVideoNameToTitle < ActiveRecord::Migration
  def change
    rename_column :videos, :name, :title
  end
end
