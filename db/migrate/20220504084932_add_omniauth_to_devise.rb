class AddOmniauthToDevise < ActiveRecord::Migration[6.0]
  def self.up
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
  def self.down
    remove_column :users, :uid
    remove_column :users, :provider
  end
end
