class AddSenderIdToUserdatum < ActiveRecord::Migration
  def change
    add_column :userdata, :sender_id, :string
  end
end
