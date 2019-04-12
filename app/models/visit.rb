class Visit < ApplicationRecord
  validates_presence_of :link_id

  belongs_to :link
end
