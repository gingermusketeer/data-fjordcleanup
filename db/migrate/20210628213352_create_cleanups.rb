class CreateCleanups < ActiveRecord::Migration[6.1]
  def change
    create_table :cleanups do |t|
      t.belongs_to :hosted_at, foreign_key: { to_table: :locations }, null: false
      t.datetime :occurred_at, null: false
      t.integer :weight, null: false

      t.timestamps
    end

    create_table :cleanups_locations do |t|
      t.belongs_to :cleanup, foreign_key: true, null: false
      t.belongs_to :location, foreign_key: true, null: false
    end
  end
end
