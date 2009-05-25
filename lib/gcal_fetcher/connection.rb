module GcalFetcher
  class Connection
    require 'feedzirra'
    attr_accessor :entries
    def initialize url=''
      url = 'localhost:4567/basic.xml' if url.empty?
      fetch url
    end
    
    def parse_okay?
      @feed.class == Feedzirra::Parser::Atom
    end

    def fetch url
      @url = url
      @feed = Feedzirra::Feed.fetch_and_parse @url
      if parse_okay?
        @entries = @feed.entries
      else
        @entries = []
      end
    end

    def sanitize!
      @feed.sanitize_entries! and @entries = @feed.entries if parse_okay?
    end
    
  end
end
