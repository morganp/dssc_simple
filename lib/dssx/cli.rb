#Based on:
#https://github.com/carlhuda/bundler/blob/master/lib/bundler/cli.rb
require 'thor'
#require './run'

module Dssx
  class CLI < Thor
    #include Thor::Actions
    desc "add [FILES]", "Add and Commit new files"
    def add(files)
      puts "dssx add #{files}" 
      puts "=> dssc cin -new #{files}" 
    end


    desc "remove [PATH]", "Remove file/folder from repository"
    def remove(path=Dir.pwd)
      puts "dssx rm #{path}" 
      puts "=> dssc retire #{path}" 
    end

    desc "rm [PATH]", "Alias for remove"
    def rm(path=Dir.pwd)
      invoke :remove
    end
    

    desc "status [PATH]", "Check status"
    def status(path=".")
      puts "dssx status #{path}"
      
      ## Create status Report
      report = Dssx::Report.new( path )
      report.list_all
    end


    option :r
    desc "update [PATH]", "Update to latest repository version"
    def update(path=Dir.pwd)
      puts "dssx update #{path}" 
      cmd =  "dssc populate -recursive -replace -full #{path}" 
      cmd = cmd + " --version #{options[:r]}" if options[:r]
      puts "=> #{cmd}" 
    end

    desc "up [PATH]", "Alias for update"
    def up(path=Dir.pwd)
      invokee :update
    end

    desc "co [URL]", "NOT IMPLEMENTED, dssc does not do checkouts"
    def commit(url=nil)
      puts "dssx does not handle checkouts" 
    end

    desc "commit[PATH]", "Commit changes to repository"
    def commit(path=Dir.pwd)
      puts "dssx commit #{path}" 
      puts "=> dssc cin #{path}" 
    end

    desc "ci [PATH]", "Alias for commit"
    def ci(path=Dir.pwd) 
      invoke :commit
    end

    desc "lock [PATH]", "Lock file"
    def ci(path=Dir.pwd) 
      puts "dssx lock #{path}" 
      puts "=> dssc co -lock -nocomment #{path}" 
    end


    desc "diff [PATH]", "Diff local modifications"
    def diff(path=Dir.pwd)
      puts "dssx diff #{path}" 
      puts "  NEED TO PASS OPTIONS CORRECTLY"
      puts "=> dssc diff #{path}" 
    end


    desc "move [PATH]", "Move a file"
    def move(path=Dir.pwd)
      puts "dssx log #{path}" 
      puts "  NOT IMPLEMENTED" 
      #puts "=> dssc vhistory #{path}" 
    end
    
    desc "log [PATH]", "View commit log"
    def log(path=Dir.pwd)
      puts "dssx log #{path}" 
      puts "=> dssc vhistory #{path}" 
    end


    desc "revert [PATH]", "Revert file back to previous version"
    def revert(path=Dir.pwd)
      puts "dssx revert #{path}" 
      puts "=> dssc cancel -force #{path}" 
    end

  end
end
