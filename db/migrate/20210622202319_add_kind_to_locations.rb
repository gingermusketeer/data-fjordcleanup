class AddKindToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :kind, :string
  end
end
