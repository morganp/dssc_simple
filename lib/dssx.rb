
module Dssx
  VERSION = '0.0.2.e'
end

begin
  require_relative 'dssx/report'

rescue
  # Ruby 1.8 Falls back here
  require 'rubygems'

  require 'dssx/report'
end

