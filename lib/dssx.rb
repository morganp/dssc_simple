
module Dssx
  VERSION = '0.1.0'
end

begin
  require_relative 'dssx/report'

rescue
  # Ruby 1.8 Falls back here
  require 'rubygems'

  require 'dssx/report'
end

