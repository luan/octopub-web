require './lib/octopub/tree_builder'

describe Octopub::TreeBuilder do
  it "can build a file description" do
    Octopub::TreeBuilder.describe('./spec/fixtures/tree1/', 'file1').should == {
      "type" => "blob",
      "path" => "file1",
      "mode" => "100644",
      "content" => Base64.encode64("this file\nhas contents\n"),
      "encoding" => "base64"
    }
  end

  it "can build a directory description" do
    Octopub::TreeBuilder.describe('./spec/fixtures/tree1/', 'subdir').should == {
      "type" => "tree",
      "path" => "subdir",
      "mode" => "040000"
    }
  end

  it "builds a tree out of a directory" do
    Octopub::TreeBuilder.build('./spec/fixtures/tree1').should == [
      {
        "type" => "blob",
        "path" => "file1",
        "mode" => "100644",
        "content" => Base64.encode64("this file\nhas contents\n"),
        "encoding" => "base64"
      }, {
        "type" => "tree",
        "path" => "subdir",
        "mode" => "040000"
      }, {
        "type" => "blob",
        "path" => "subdir/subfile",
        "mode" => "100644",
        "content" => Base64.encode64("subfile\ncontents\n"),
        "encoding" => "base64"
      }
    ]
  end
end
