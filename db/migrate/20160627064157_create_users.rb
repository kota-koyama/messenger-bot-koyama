class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :boy
      t.integer :userpoint
      t.integer :yamapoint
      t.integer :kusapoint
      t.integer :koyapoint
      t.integer :kawapoint
      t.integer :nakapoint
      t.time :usertime

      t.timestamps null: false
    end
  end
end
