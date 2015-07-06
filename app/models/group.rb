class Group < ActiveRecord::Base
  validates :name, null: false
end
