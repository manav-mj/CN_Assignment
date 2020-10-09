class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.references :doubt, foreign_key: true
      t.boolean :accept, default: false
      t.boolean :escalate, default: false
      t.boolean :resolve, default: false
      t.timestamp :accept_time
      t.timestamp :escalate_time
      t.timestamp :resolve_time
      t.bigint :activity_time

      t.timestamps
    end
  end
end
