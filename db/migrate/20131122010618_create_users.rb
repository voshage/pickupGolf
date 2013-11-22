class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :profile_name
      t.string :email

      t.string :content

      t.timestamps
    end

    add_index :users, :email, :unique => true
  end
end
