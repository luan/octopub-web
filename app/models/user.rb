class User < ActiveRecord::Base
  validates :username, uniqueness: true, presence: true
  validates :token, uniqueness: true

  has_many :blogs

  def octopub
    @octopub ||= Octopub.new(token)
  end

  def create_blog(name)
    repo_name = name.downcase.gsub(/\s/, '-')
    octopub.create_repo repo_name
    blogs << Blog.create(name: name, repo: repo_name)
  end
end
