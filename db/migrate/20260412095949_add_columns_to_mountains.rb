class AddColumnsToMountains < ActiveRecord::Migration[7.2]
  def change
    add_column :mountains, :cable_car, :boolean
    add_column :mountains, :name_kana, :string
    add_column :mountains, :narrative, :text
    add_column :mountains, :main_course, :string
  end
end
