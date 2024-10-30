require 'rails_helper'

RSpec.describe EventParticipant, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end
end
