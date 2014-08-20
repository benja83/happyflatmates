class Event < ActiveRecord::Base
  belongs_to :flat

  validates :start, presence: true
  validates :end, presence: true
  validates :title, presence: true

end
