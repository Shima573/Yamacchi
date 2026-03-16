class CreateMountains < ActiveRecord::Migration[7.2]
  def change
    create_table :mountains do |t|
      t.string :name, null: false
      t.integer :elevation
      t.string :prefecture
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.integer :raw_physical_grade
      t.string :raw_technical_grade
      t.string :grade_source_prefecture
      t.integer :normalized_physical_score
      t.integer :normalized_technical_score
      t.boolean :has_toilet, default: false, null: false
      t.text :access_detail
      t.string :image_url

      t.timestamps
    end
      # インデックス（検索を速くする設定）も追加
      add_index :mountains, :name
      add_index :mountains, :prefecture
  end
end
