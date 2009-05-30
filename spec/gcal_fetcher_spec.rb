require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe GcalFetcher::Connection do
  before :all do @sinatra_pid = start_sinatra; end
  after :all do stop_sinatra(@sinatra_pid); end
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

describe GcalFetcher::Item do
  before :all do
    @sinatra_pid = start_sinatra and @c = GcalFetcher::Connection.new
    @items = @c.entries.map{|entry| GcalFetcher::Item.new(entry)}
    @n_entries = @c.entries.size
  end
  after :all do stop_sinatra(@sinatra_pid); end
  
  it "should have a title" do
    @items.select{|item| item.title.class == String}.size.should be @n_entries
  end
  it "should have an author" do
    @items.select{|item| item.author.class == String}.size.should be @n_entries
  end
  it "should have a begin date" do
    @items.select{|item| item.begins_at.class == DateTime}.size.should be @n_entries
  end
  it "should have an end date" do
    @items.select{|item| item.ends_at.class == DateTime}.size.should be @n_entries
  end
  it "should have an status" do
    @items.select{|item| item.status.class}.size.should be @n_entries
  end
end

describe "grouped feeds" do
  before :all do
  
  end
  
  it "should have all events mapped"

  it "all events should have dates"

end
