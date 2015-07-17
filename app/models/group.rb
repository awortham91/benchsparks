class Group < ActiveRecord::Base
  validates :name, null: false
  has_and_belongs_to_many :users
end
