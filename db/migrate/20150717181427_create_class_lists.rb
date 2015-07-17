class CreateClassLists < ActiveRecord::Migration
  def change
    create_table :class_lists do |t|
      t.integer :group_id
      t.integer :user_id
    end
  end
end
