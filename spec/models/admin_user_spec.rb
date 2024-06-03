# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminUser do
  it 'has a valid factory' do
    expect(build(:admin_user)).to be_valid
  end

  describe 'validations' do
    it 'validates presence of email' do
      expect(described_class.new).to validate_presence_of(:email)
    end

    it 'validates presence of password' do
      expect(described_class.new).to validate_presence_of(:password)
    end
  end
end
