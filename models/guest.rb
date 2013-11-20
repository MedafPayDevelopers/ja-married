class Guest < ActiveRecord::Base

  scope :as_you_type, lambda {|name|
    where("name ILIKE ?", "%#{name}%")
  }

end
