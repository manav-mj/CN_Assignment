class CreateDoubts < ActiveRecord::Migration[5.1]
  def change
    create_table :doubts do |t|
      t.string :title
      t.text :body
      t.boolean :accepted, default: false
      t.boolean :resolved, default: false
      t.references :resolved_by, foreign_key: {to_table: :users}, index: true
      t.timestamp :accepted_on
      t.timestamp :resolved_on
      t.boolean :escalated, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
