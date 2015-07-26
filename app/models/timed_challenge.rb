class Timed_challenge < ActiveRecord::Base
  has_one :level
  has_one :user
  validates :score, numericality: { only_integer: true }
end
