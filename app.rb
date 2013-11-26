require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/guest'
require 'json'
require 'sinatra/form_helpers'
require 'rack-flash'
require 'sinatra/partial'

set :haml, format: :html5
enable :partial_underscores


use Rack::Session::Cookie, key: 'rack.session',
                           domain: 'heroku.com',
                           path: '/',
                           expire_after: 2592000,
                           secret: 'ja-is-getting-married-so-we-need-a-secret-token'
use Rack::Flash

get '/' do
  haml :index
end

get '/our_story' do
  haml :our_story
end

get '/proposal' do
  haml :proposal
end

get '/our_bio' do
  haml :our_bio
end

get '/venue' do
  haml :venue
end

get '/wedding_party' do
  haml :wedding_party
end

get '/rsvp' do
  haml :rsvp
end

post '/rsvp_action' do
  puts params.inspect

  guest_params = params.delete('guest')
  guest_id = guest_params.delete('id')
  guest_name = guest_params.delete('name')

  guest = Guest.find_by_id(guest_id)
  guest.update_attributes(guest_params)

  flash[:notice] = "Thank you for RSVPing! We look forward to seeing you."
  redirect '/rsvp'
end

get '/guests.?:format?' do
  content_type :json

  puts params.inspect
  @guests = Guest.as_you_type(params[:guest_name]).collect{|x| [name: x.name, id: x.id, plus_one: x.can_plus_one]}

  {matchingGuests: @guests.flatten}.to_json

end
