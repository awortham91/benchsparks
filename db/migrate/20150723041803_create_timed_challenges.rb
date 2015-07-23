class CreateTimedChallenges < ActiveRecord::Migration
  def change
    create_table :timed_challenges do |t|
      t.integer :user_id
      t.integer :level_id
      t.integer :score
    end
  end
end
