class CreateDiagnoses < ActiveRecord::Migration[7.2]
  def change
    create_table :diagnoses do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :total_score, null: false
      t.integer :recommended_physical_min, null: false, default: 0
      t.integer :recommended_physical_max, null: false, default: 0
      t.integer :recommended_technical_max, null: false, default: 0

      t.timestamps
    end
  end
end
