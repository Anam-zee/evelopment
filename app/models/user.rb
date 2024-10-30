class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :organized_events, class_name: 'Event', foreign_key: 'organizer_id'
  has_many :event_participants
  has_many :joined_events, through: :event_participants, source: :event
end
