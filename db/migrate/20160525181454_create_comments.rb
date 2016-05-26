class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.timestamps
      t.belongs_to :post, index: true
    end
  end
end
