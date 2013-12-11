require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/guest'
require 'json'
require 'sinatra/form_helpers'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'sinatra/partial'
require 'pony'

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

  if @guest.name != guest_name || (guest_params['has_plus_one'] && guest_params['has_plus_one'] == 'on' && !@guest.can_plus_one)
    redirect '/rsvp', error: "We are sorry. Something is wrong. Would you select your name from the dropdown and resubmit please?"
  else
    @guest.attributes = guest_params
    @guest.rsvp_ed = true

    if @guest.save
      @num_unconfimed_guests = Guest.where(rsvp_ed: false).count
      Pony.mail({to: 'irregular.profit@gmail.com',
                 from: 'irregular.profit@gmail.com',
                 subject: "Wedding RRSP: #{@guest.name}",
                 html_body: haml(:email),
                 via: :smtp,
                 via_options: {
                   address:              'smtp.gmail.com',
                   port:                 '587',
                   enable_starttls_auto: true,
                   user_name:            'irregular.profit',
                   password:             'uqjseayluuzmoojy',
                   authentication:       :plain,
                   domain:               "localdomain"
      }})
      first_name = @guest.name.split(' ').first
      redirect '/rsvp', notice: "Thank you for RSVPing #{first_name}! We look forward to seeing you."
    else
      redirect '/rsvp', error: "Something is wrong :(. We weren't able to RSVP you. Please call Jimmy."
    end
  end

end

get '/guests.?:format?' do
  content_type :json

  puts params.inspect
  @guests = Guest.where(rsvp_ed: false).as_you_type(params[:guest_name]).collect{|x| [name: x.name, id: x.id, plus_one: x.can_plus_one]}

  {matchingGuests: @guests.flatten}.to_json

end
