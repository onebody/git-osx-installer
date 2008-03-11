#!/bin/sh
ruby=`which ruby /opt/local/bin/ruby /usr/local/bin/ruby | uniq`
echo $ruby
$ruby <<-EOF
  require 'fileutils'
  GIT_DIR = "/usr/local/git/bin"

  dir = "#{ENV['HOME']}/.MacOSX/"
  FileUtils.mkdir_p(dir)

  puts "modifying the MacOSX environment.plist file"
  Dir.chdir(dir) do 
    paths = if File.exist?("environment.plist")
      %x{defaults read ~/.MacOSX/environment PATH}.strip.split(":")
    else
      ENV["PATH"].split(":")
    end
    paths << GIT_DIR
    path = paths.uniq * ":"
    puts %x{defaults write ~/.MacOSX/environment PATH "#{path}"}
  end

  puts "Modifying ~/.profile"
  Dir.chdir(ENV["HOME"]) do
    profile = File.exist?(".profile") ? File.read(".profile") : ""
    unless /PATH.+#{Regexp.escape(GIT_DIR)}/.match(profile)
      profile << "\nexport PATH=#{GIT_DIR}:\$PATH\n"
      File.open(".profile", "wb") { |f| f << profile }
    end
  end
EOF
