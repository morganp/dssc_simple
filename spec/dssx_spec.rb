
require 'spec_helper'

describe Dssx::Report do
  it "run_dssc_ls should be filtered" do
    
    report = Dssx::Report.new()
    report.stub!(:run_dssc_ls_mock) do
      absolute_filename = 
        ::File.absolute_path(
          ::File.join( 
            ::File.dirname(__FILE__), 'fixtures', 'mock_output.txt' 
          ) 
        )
      result = ''  
      ::File.open( absolute_filename, "rb"){ |f| result = f.read }
      
      result.split("\n") 
    end
    
    display = report.list_cached

    report.list_all
    display.should_not be_nil
  end
end


