class User < ActiveRecord::Base
  validates :username, uniqueness: true, presence: true
  validates :token, uniqueness: true
end
