%w(rubygems sinatra).each {|r| require r}

get '/' do
  "You shouldn't be there."
end
