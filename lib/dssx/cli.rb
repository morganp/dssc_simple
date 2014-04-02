#Based on:
#https://github.com/carlhuda/bundler/blob/master/lib/bundler/cli.rb
require 'thor'
#require './run'

module Dssx
  class CLI < Thor
    #include Thor::Actions
    class_option :version, :type => :boolean
    desc "version", "Show dssx version"
    def version
      if options[:version]
        puts "dssx version #{find_version}"
      end
    end
    default_task :version

    
    desc "add [FILES]", "Add and Commit new files"
    def add(file, *files_splat)
      file_list = flatten_default_splat(file, files_splat)
      puts "dssx add #{file_list}" 
      puts "=> dssc ci -new #{file_list}" 
    end


    desc "remove [PATH]", "Remove file/folder from repository"
    def remove(path, *path_splat)
      path_list = flatten_default_splat(path, path_splat)
      puts "dssx remove #{path_list}" 
      puts "=> dssc retire #{path_list}" 
    end

    desc "rm [PATH]", "Alias for remove"
    def rm(path, *path_splat)
      invoke :remove
    end


    option :verbose, :type => :boolean
    desc "status [PATH]", "Check status"
    def status(path=".")
      puts "dssx status #{path}"
      ## Create status Report
      report = Dssx::Report.new( path )
      report.list_all
    end


    option :r
    desc "update [PATH]", "Update to latest repository version"
    def update(path=Dir.pwd, *path_splat)
      path_list = flatten_default_splat(path, path_splat)
      puts "dssx update #{path_list}" 
      cmd =  "dssc populate -recursive -replace -unify #{path_list}" 
      cmd = cmd + " --version #{options[:r]}" if options[:r]
      puts "=> #{cmd}" 
    end

    desc "up [PATH]", "Alias for update"
    def up(path=Dir.pwd, *path_splat)
      invoke :update
    end

    desc "co [URL]", "NOT IMPLEMENTED, dssc does not do checkouts"
    def co(url=nil)
      puts "dssx does not handle checkouts" 
    end

    desc "commit[PATH]", "Commit changes to repository"
    def commit(path=Dir.pwd, *path_splat)
      path_list = flatten_default_splat(path, path_splat)
      puts "dssx commit #{path_list}" 
      puts "=> dssc ci #{path_list}" 
    end

    desc "ci [PATH]", "Alias for commit"
    def ci(path=Dir.pwd, *path_splat) 
      invoke :commit
    end

    desc "lock [PATH]", "Lock file"
    def lock(path=Dir.pwd, *path_splat) 
      path_list = flatten_default_splat(path, path_splat)
      puts "dssx lock #{path_list}" 
      puts "=> dssc co -lock -nocomment #{path_list}" 
    end


    desc "diff [PATH]", "Diff local modifications"
    def diff(path=Dir.pwd)
      puts "dssx diff #{path}" 
      puts "  NEED TO PASS OPTIONS CORRECTLY"
      puts "=> dssc diff #{path}" 
    end


    desc "move [PATH]", "Move a file"
    def move(path=Dir.pwd)
      puts "dssx move #{path}" 
      puts "  NOT IMPLEMENTED" 
      #puts "=> dssc vhistory #{path}" 
    end

    desc "log [PATH]", "View commit log"
    def log(path=Dir.pwd)
      puts "dssx log #{path}" 
      puts "=> dssc vhistory #{path}" 
    end


    desc "revert [PATH]", "Revert file back to previous version"
    def revert(path=Dir.pwd, *path_splat)
      path_list = flatten_default_splat(path, path_splat)
      puts "dssx revert #{path_list}" 
      puts "=> dssc cancel -force #{path_list}" 
    end

    ## Helper Functions 
    #    NOT Thor Tasks
    no_tasks do
      def flatten_default_splat(a, *b)
        path_list = a + ' ' + b * ' ' 
      end
      
      ## name and versio taken from 
      ## https://github.com/mojombo/rakegem
      def name
        #@name ||= Dir['*.gemspec'].first.split('.').first
        'dssx'
      end

      def find_version
        lib_path     = File.expand_path( File.join(File.dirname(__FILE__), '..'))
        version_file = File.join(lib_path, "#{name}.rb")
        line         = File.read( version_file )[/^\s*VERSION\s*=\s*.*/]
        line.match(/.*VERSION\s*=\s*['"](.*)['"]/)[1]
      end

    end
  end
end
