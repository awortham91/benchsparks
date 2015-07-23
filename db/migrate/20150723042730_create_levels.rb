class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :level
    end
  end
end
