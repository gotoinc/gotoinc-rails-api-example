class AddAttributesToBuilding < ActiveRecord::Migration[6.0]
  def change
    add_column :buildings, :temperature, :string
    add_column :buildings, :air_quality, :string
    add_column :buildings, :urgent_message, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
