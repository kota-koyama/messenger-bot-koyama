class AddSuzuPointToUserdatum < ActiveRecord::Migration
  def change
    add_column :userdata, :suzu_point, :integer
  end
end
