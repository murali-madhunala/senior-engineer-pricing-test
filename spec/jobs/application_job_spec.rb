# frozen_string_literal: true

require 'rails_helper'

# The application job is a base class
# We test here there at can operate as a base class without throwing errors
RSpec.describe ApplicationJob do
  describe 'perform' do
    let(:dummy_class) do
      Class.new described_class do
        def perform
          puts 'Hello World!'
        end
      end
    end

    it 'sends an email' do
      expect { dummy_class.perform_now }.to output("Hello World!\n").to_stdout
    end
  end
end
