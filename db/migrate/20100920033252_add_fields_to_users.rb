class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
   	add_column :users,:clientInternalID,:string
  	add_column :users,:ClientLogoImageName,:string
  	add_column :users,:perfStartScript,:string
  	add_column :users,:availabiltyStartScript,:string
  	add_column :users,:faultStartScript,:string
  	add_column :users,:capacityStartScript,:string
  	add_column :users,:configStartScript,:string
  end

  def self.down
  	remove_column :users,:clientInternalID
  	remove_column :users,:ClientLogoImageName
  	remove_column :users,:perfStartScript
  	remove_column :users,:availabiltyStartScript
  	remove_column :users,:faultStartScript
  	remove_column :users,:capacityStartScript
  	remove_column :users,:configStartScript
  end
end
