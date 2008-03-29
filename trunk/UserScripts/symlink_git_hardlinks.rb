#!/usr/bin/env ruby
Dir.chdir('/usr/local/git/bin')
puts files = (Dir.glob("*").select { |f| File.size(f)==File.size('git')} - ['git'])
files.each do |file|
  puts `rm #{file} && ln -s git #{file}`
end