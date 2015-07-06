class Userquestion < ActiveRecord::Base
  has_many :users
  has_many :questions
  validates :answer, numericality: { only_integer: true }
end
