class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.timestamps
      t.belongs_to :post, index: true
    end
  end
end
