class CreateUserQuestionStats < ActiveRecord::Migration
  def change
    create_table :userquestionstats do |t|
      t.integer :user_id
      t.integer :total_questions
      t.integer :correct
      t.integer :incorrect
    end
  end
end
