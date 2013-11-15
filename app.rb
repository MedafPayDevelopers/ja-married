require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/guest'

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

