module Octopub
  class OctopressCloner
    def self.clone
      uri = 'http://github.com/imathis/octopress/tarball/master'
      `mkdir -p tmp`
      `rm -rf tmp/octopress*`
      `cd tmp && curl -Ls #{uri} > octopress.tar.gz`
      `cd tmp && tar xzf octopress.tar.gz`
      `cd tmp && mv imathis-octopress* octopress`
    end
  end
end
