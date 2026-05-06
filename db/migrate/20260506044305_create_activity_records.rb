class CreateActivityRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :activity_records do |t|
      t.string :title, null: false
      t.text :body
      t.datetime :climbed_at, null: false
      t.references :user, null: false, foreign_key: true
      t.references :mountain, null: false, foreign_key: true

      t.timestamps
    end
  end
end
