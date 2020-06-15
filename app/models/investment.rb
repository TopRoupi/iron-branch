class Investment < ApplicationRecord
  belongs_to :investor, class_name: "Company"
  belongs_to :invested, class_name: "Company"
  enum funds: [:actions, :cotes]
end
