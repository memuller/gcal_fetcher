require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
begin
@sinatra_pid = start_sinatra
describe GcalFetcher::Connection do
  before(:each)do
    @c = GcalFetcher::Connection.new
  end
  
  it "should load the test feed" do
    @c.entries.should_not be_empty
  end
  it "should return an empty array upon failure" do
    @c.fetch('localhost:4567/null.xml')
    @c.entries.should == []
  end
  it "should have all entries sanitized" do
    @c.entries.first.content << "<script>evil tag of doom!</script>"
    @c.sanitize!
    @c.entries.first.content['<script>'].should be nil
  end

end

describe "feed information" do
  before :all do
  
  end
  it "should have a title"

  it "should have an author"

  it "should have a begin date"

  it "should have an status"

end

describe "grouped feeds" do
  before :all do
  
  end
  
  it "should have all events mapped"

  it "all events should have dates"

end
ensure
stop_sinatra(@sinatra_pid)
end
