class CreateGuest < ActiveRecord::Migration
  def up
    create_table :guests do |t|
      t.string  :name
      t.boolean :can_plus_one
      t.boolean :has_plus_one
      t.string  :plus_one_name
      t.boolean :rsvp_ed
    end
  end

  def down
    drop_table :guests
  end
end
