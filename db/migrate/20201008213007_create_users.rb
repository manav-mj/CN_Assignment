class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, unique: true
      t.string :password_digest
      t.string :role, default: "student"

      t.timestamps
    end
  end
end
