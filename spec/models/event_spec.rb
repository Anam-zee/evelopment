# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Associations' do
    it { should belong_to(:organizer).class_name('User') }
    it { should have_many(:event_participants) }
    it { should have_many(:joiners).through(:event_participants).source(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:date) }
  end
end
