class User < ActiveRecord::Base
  has_many :questions, through: :userquestion
  belongs_to :userquestion
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
end
