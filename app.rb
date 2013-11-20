require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/guest'
require 'json'
require 'sinatra/form_helpers'

set :haml, format: :html5

get '/' do
  haml :index
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

get '/groomsmen/:name' do |n|
  "Hello #{n}! This is your bio"
end

get '/rsvp' do
  @guests = Guest.all
  haml :rsvp
end

post '/rsvp_action' do
  puts params.inspect

end


get '/guests.?:format?' do
  content_type :json

  puts params.inspect
  @guests = Guest.as_you_type(params[:guest_name]).collect{|x| [name: x.name, id: x.id, plus_one: x.plus_one_allowed]}

  {matchingGuests: @guests.flatten}.to_json

end
