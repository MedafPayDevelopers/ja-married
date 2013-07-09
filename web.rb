require 'sinatra'

get '/' do
  "Hello World! We are getting married!"
end

get '/alice' do
  'Hello Alice! You should fill out your bio here!'
end

get '/jimmy' do
  'Hello Jimmy! Where is your bio'
end

get '/bridesmaids/:name' do |n|
  "Hello #{n}! This is your bio"
end

get 'groomsmen/:name' do |n|
  "Hello #{n}! This is your bio"
end

get '/bridesmaids/maya' do

end

get '/bridesmaids/gladys' do

end

get '/bridesmaids/ivy' do

end

get '/groomsmen/michael' do

end

get '/groomsmen/peter' do

end

get '/groomsmen/tam' do

end
