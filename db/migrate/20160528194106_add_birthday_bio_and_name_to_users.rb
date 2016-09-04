class AddBirthdayBioAndNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
    add_column :users, :bio, :text
    add_column :users, :name, :string
  end
end
