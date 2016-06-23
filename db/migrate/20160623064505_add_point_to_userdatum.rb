class AddPointToUserdatum < ActiveRecord::Migration
  def change
    add_column :userdata, :point, :integer
  end
end
