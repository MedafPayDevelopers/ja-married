class PopulateGuestList < ActiveRecord::Migration
  def up
    Guest.create(
      name: "Alice Liu",
      can_plus_one: true,
      plus_one_name: ""
    )

    Guest.create(
      name: "Helen Kuo",
      can_plus_one: true,
      plus_one_name: ""
    )

  end

  def down
    Guest.delete_all
  end
end
