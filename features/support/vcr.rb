VCR.configure do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
    record: :new_episodes,
    re_record_interval: 7.days
  }
end

VCR.cucumber_tags do |t|
  t.tag '@github-web', use_scenario_name: true
  t.tag '@vcr', use_scenario_name: true
end
