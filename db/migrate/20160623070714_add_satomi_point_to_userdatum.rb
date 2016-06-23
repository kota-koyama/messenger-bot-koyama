class AddSatomiPointToUserdatum < ActiveRecord::Migration
  def change
    add_column :userdata, :satomi_point, :integer
  end
end
