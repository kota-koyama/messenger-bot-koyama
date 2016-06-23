class AddHarukaPointToUserdatum < ActiveRecord::Migration
  def change
    add_column :userdata, :haruka_point, :integer
  end
end
