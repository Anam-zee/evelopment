# spec/helpers/events_helper_spec.rb
require 'rails_helper'

RSpec.describe EventsHelper, type: :helper do
  describe '#user_avatar_with_initials' do
    it 'returns HTML with user initials and random background color' do
      username = 'John Doe'
      allow(helper).to receive(:random_hex_color).with(username).and_return('#123456')

      result = helper.user_avatar_with_initials(username)

      expect(result).to include('<div class="avatar w-12 h-12 text-white font-bold flex justify-center border border-white items-center" style="background-color: #123456;">JD</div>')
    end
  end

  describe '#random_hex_color' do
    it 'returns a valid hex color code' do
      name = 'John Doe'
      result = helper.send(:random_hex_color, name)  # Using send to access private method

      expect(result).to match(/^#[0-9a-fA-F]{6}$/)
    end
  end

  describe '#is_joined' do
    let(:event) { create(:event) }
    let(:user) { create(:user) }

    it 'returns true if user is joined' do
      event.joiners << user
      result = helper.send(:is_joined, event, user)  # Using send to access private method

      expect(result).to be true
    end

    it 'returns false if user is not joined' do
      result = helper.send(:is_joined, event, user)  # Using send to access private method

      expect(result).to be false
    end
  end
end
