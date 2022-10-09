# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRole, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :role }
  end
end
