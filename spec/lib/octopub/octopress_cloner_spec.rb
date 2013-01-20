require './lib/octopub/octopress_cloner'

describe Octopub::OctopressCloner do
  it "downloads and unzips the octopress' repo" do
    Octopub::OctopressCloner.clone
    File.exists?('./tmp/octopress/README.markdown').should be_true
    `rm -rf tmp/octopress*`
  end
end
