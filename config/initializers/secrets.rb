module Secrets
  def self.[](key)
    unless @config
      begin
        raw_config = File.read("#{Rails.root}/config/secrets.yml")
        @config = YAML.load(raw_config)[Rails.env].symbolize_keys
      rescue Errno::ENOENT
        @config = ENV.to_hash.symbolize_keys
      end
    end
    @config[key]
  end

  def self.[]=(key, value)
    @config[key.to_sym] = value
  end
end

