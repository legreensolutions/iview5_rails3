class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
		  t.string	:email,:null => false# optional, you can use login instead, or both
		  t.string  :crypted_password, :null => false # optional, see below
		  t.string 	:password_salt, :null => false  # optional, but highly recommended
		  t.string 	:persistence_token,:null => false # required
		  t.string 	:single_access_token, :null => false # optional, see Authlogic::Session::Params
		  t.string 	:perishable_token,:null => false # optional, see Authlogic::Session::Perishability
		  t.string  :name,:null=>false
		  t.string  :company,:null=>false
			t.integer :active,:default=>0
			t.boolean :is_admin,:default=>false
      t.timestamps
    end
      @admin = User.create!(:email=>'admin@gmail.com',:password=>'12345678',:password_confirmation=>'12345678',:name=>'admin',:company=>'admin',:active=>1,:is_admin=>true)
 
      
  end

  def self.down
    drop_table :users
  end
end
