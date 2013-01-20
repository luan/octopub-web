require './lib/octopub/tree_builder'

describe Octopub::TreeBuilder do
  it "can build a file description" do
    Octopub::TreeBuilder.describe('./spec/fixtures/tree1/', 'file1').should == {
      "type" => "blob",
      "path" => "file1",
      "mode" => "100644",
      "content" => "this file\nhas contents\n"
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
        "content" => "this file\nhas contents\n"
      }, {
        "type" => "tree",
        "path" => "subdir",
        "mode" => "040000"
      }, {
        "type" => "blob",
        "path" => "subdir/subfile",
        "mode" => "100644",
        "content" => "subfile\ncontents\n"
      }, {
        "type" => "tree",
        "path" => "subdir/subsubdir",
        "mode" => "040000"
      }, {
        "type" => "blob",
        "path" => "subdir/subsubdir/subsubfile",
        "mode" => "100644",
        "content" => ""
      }
    ]
  end
end
