class Blog < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :repo

  validates :name, presence: true
  validates :repo, presence: true, uniqueness: { scope: :user_id }
end
