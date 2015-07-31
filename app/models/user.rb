class User < ActiveRecord::Base
  has_many :questions, through: :userquestion
  has_one :userquestion
  has_many :usergroups
  has_many :groups, through: :usergroups
  belongs_to :usergroup
  has_one :userquestionstat
  has_many :timed_challenges
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, null: false
  validates :password, null: false

  def self.order_by_correct_answer_percentage
    all.sort_by(&:correct_answer_percentage)
  end

  def correct_answer_percentage
    correctly_answered_questions.to_f / total_questions
  end

  def correctly_answered_questions
    if userquestionstat
      if userquestionstat.correct > 0
        userquestionstat.correct
      else
        0
      end
    else
      0
    end
  end

  def total_questions
    if userquestionstat
      userquestionstat.total_questions
    else
      0.00001
    end
  end
end
