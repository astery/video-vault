class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.datetime :show_at

      t.timestamps null: false
    end
  end
end
