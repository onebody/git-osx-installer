#!/bin/sh
ruby=`which ruby /opt/local/bin/ruby /usr/local/bin/ruby | uniq`
echo $ruby
$ruby <<-EOF 2>&1 > /tmp/git_path_output.txt
  require 'fileutils'
  GIT_DIR = "/usr/local/git/bin"
  GIT_MAN_DIR = "/usr/local/git/man"

  ENV_PLIST_DIR = "#{ENV['HOME']}/.MacOSX/"
  FileUtils.mkdir_p(ENV_PLIST_DIR)
  
  def append_plist_var(name, append_value, default_value = nil)
    Dir.chdir(ENV_PLIST_DIR) do 
      puts "1"
      values = File.exist?("environment.plist") ? %x{defaults read ~/.MacOSX/environment #{name}}.strip.split(":") : []
      puts "2 - #{ENV.inspect} - #{name}"
      values = (ENV[name] || default_value || "").split(":") if values.empty?
      puts "3"
      values << append_value
      puts "4"
      output = values.uniq * ":"
      puts "5"
      puts %x{defaults write ~/.MacOSX/environment #{name} "#{output}"}
    end
  end
  
  def append_script_var(name, append_value)
  
    Dir.chdir(ENV["HOME"]) do
      target_files = [".profile", ".bash_profile"].select{|filename| File.exist?(filename) }
      target_files = [".bash_profile"] if target_files == []
      
      target_files.each do |filename|
        profile = File.exist?(filename) ? File.read(filename) : ""
        unless /#{name}.+#{Regexp.escape(append_value)}/.match(profile)
          profile << "\nexport #{name}=#{append_value}:\$#{name}\n"
          File.open(filename, "wb") { |f| f << profile }
        end
      end
    end
  end
  
  puts "modifying the MacOSX environment.plist PATH variable"
  append_plist_var("PATH", GIT_DIR, "/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/local/bin")
  
  puts "modifying the MacOSX environment.plist MANPATH variable"
  append_plist_var("MANPATH", GIT_MAN_DIR, "/usr/local/man:/usr/share/man:/usr/local/share/man:/usr/X11/man")
  
  puts "modifying PATH variable"
  append_script_var("PATH", GIT_DIR)
  
  puts "modifying MANPATH variable"
  append_script_var("MANPATH", GIT_MAN_DIR)
  
  puts "All done!"
EOF
