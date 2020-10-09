class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.references :doubt, foreign_key: true
      t.string :event_type

      t.timestamps
    end
  end
end
