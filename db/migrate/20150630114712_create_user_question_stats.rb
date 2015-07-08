class CreateUserQuestionStats < ActiveRecord::Migration
  def change
    create_table :userquestionstats do |t|
      t.integer :user_id
      t.integer :total_questions, default: 0
      t.integer :correct, default: 0
      t.integer :incorrect, default: 0
    end
  end
end
