class User < ActiveRecord::Base
  validates :username, uniqueness: true, presence: true
  validates :token, uniqueness: true

  has_many :blogs

  def octopub
    @octopub ||= Octopub.new(token)
  end

  def create_blog(name)
    blog = octopub.create_blog(name)
    blogs << Blog.create(name: name, repo: blog.repo)
    blog.clone_octopress
  end
end
