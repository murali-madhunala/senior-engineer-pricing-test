# frozen_string_literal: true

require 'rails_helper'

# The application mailer is a base class
# We test here there at can operate as a base class without throwing errors
RSpec.describe ApplicationMailer do
  describe 'notify' do
    let(:dummy_class) do
      Class.new described_class do
        def new_order_email
          mail(to: 'someone@example.com', subject: 'You got a new order!', body: 'Email body') # rubocop:disable Rails/I18nLocaleTexts
        end
      end
    end
    let(:mail) { dummy_class.new_order_email }

    it 'sets defaults values' do
      expect(mail.from).to eq ['from@example.com']
    end

    it 'sends an email' do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
