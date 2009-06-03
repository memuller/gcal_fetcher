require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe GcalFetcher::Helper do
  before :all do
    @compound_date = "qua 6 de mai de 2009 10:00 a 11:00"
    @date_str = "qua 6 de mai de 2009 10:00"
  end

  it "should split a compound date range to an Array of two DateTime objects" do
    dates = GcalFetcher::Helper.split_compound_date(@compound_date)
    dates.first.class.should be DateTime
    dates.last.class.should be DateTime
  end

  it "should convert a date string in pt to a DateTime object" do
    GcalFetcher::Helper.date_convert_str(@date_str).class.should be DateTime
  end
end

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
