class Group < ActiveRecord::Base
  validates :name, null: false
  has_many :usergroups
  has_many :users, through: :usergroups
  belongs_to :usergroup
  accepts_nested_attributes_for :usergroups
end
