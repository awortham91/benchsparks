class AddBenchsparkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :benchspark, :integer, default: 1
  end
end
