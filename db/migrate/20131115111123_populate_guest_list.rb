require 'csv'

class PopulateGuestList < ActiveRecord::Migration
  def up
    CSV.foreach('db/guests.csv') do |row|
      guest = Guest.create(
        name: row[0],
        can_plus_one: !row[1].blank?,
        has_plus_one: false,
        plus_one_name: "",
        rsvp_ed: false
      )
      puts "Guest created: #{guest.inspect}"
    end
  end

  def down
    Guest.delete_all
  end
end
