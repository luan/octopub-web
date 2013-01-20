module Octopub
  class TreeBuilder
    def self.describe(path, file)
      path = File.join path, file

      if File.directory? path
        {
          "type" => "tree",
          "path" => file,
          "mode" => "040000"
        }
      else
        {
          "type" => "blob",
          "path" => file,
          "mode" => "100644",
          "content" => File.read(path)
        }
      end
    end

    def self.build(path)
      path += '/' if path[-1] != '/'

      Dir[path + '**/*'].map do |file|
        describe path, file.gsub(path, '')
      end
    end
  end
end
