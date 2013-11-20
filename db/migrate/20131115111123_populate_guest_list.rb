class PopulateGuestList < ActiveRecord::Migration
  def up
    Guest.create(
      name: "Alice Liu",
      plus_one_allowed: true,
      plus_one_name: ""
    )

    Guest.create(
      name: "Helen Kuo",
      plus_one_allowed: true,
      plus_one_name: "Victor"
    )

  end

  def down
    Guest.delete_all
  end
end
