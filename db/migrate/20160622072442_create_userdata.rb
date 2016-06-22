class CreateUserdata < ActiveRecord::Migration
  def change
    create_table :userdata do |t|
      t.string :girl
      t.time :backtime

      t.timestamps null: false
    end
  end
end
