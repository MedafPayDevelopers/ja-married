require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/guest'
require 'json'
require 'sinatra/form_helpers'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'sinatra/partial'

set :haml, format: :html5
enable :partial_underscores
enable :sessions

get '/' do
  @background = 'green'
  haml :index
end

get '/our_story' do
  @item = 1
  @background = 'green'
  haml :our_story
end

get '/proposal' do
  @item = 2
  @background = 'green'
  haml :proposal
end

get '/our_bio' do
  @item = 3
  @background = 'white'
  haml :our_bio
end

get '/wedding_party' do
  @item = 4
  @background = 'white'
  haml :wedding_party
end

get '/venue' do
  @item = 5
  @background = 'yellow'
  haml :venue
end

get '/rsvp' do
  @background = 'white'
  haml :rsvp
end

post '/rsvp_action' do
  puts params.inspect

  guest_params = params.delete('guest')
  guest_id = guest_params.delete('id')
  guest_name = guest_params.delete('name')

  @guest = Guest.find_by_id(guest_id)
  @guest.update_attributes(guest_params)

  Pony.mail to: 'irregular.profit@gmail.com',
            from: 'irregular.profit@gmail.com',
            subject: "Wedding RRSP: #{guest.name}",
            body: haml(:email)

  redirect '/rsvp', notice: 'Thank you for RSVPing! We look forward to seeing you.'
end

get '/guests.?:format?' do
  content_type :json

  puts params.inspect
  @guests = Guest.as_you_type(params[:guest_name]).collect{|x| [name: x.name, id: x.id, plus_one: x.can_plus_one]}

  {matchingGuests: @guests.flatten}.to_json

end
