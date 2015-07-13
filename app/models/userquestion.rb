class Userquestion < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  validates :answer, numericality: { only_integer: true }
end
