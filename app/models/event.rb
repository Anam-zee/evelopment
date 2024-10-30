class Event < ApplicationRecord
  belongs_to :organizer, class_name: 'User'
  has_many :event_participants, dependent: :destroy
  has_many :joiners, through: :event_participants, source: :user

  validates :name, :location, :description, :date, presence: true
end