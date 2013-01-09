class User < ActiveRecord::Base
  validates :username, uniqueness: true, presence: true

  def self.create_with_username(username)
    create do |user|
      user.username = username
    end
  end
end
