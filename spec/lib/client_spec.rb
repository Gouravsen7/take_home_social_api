require 'rails_helper'

describe Client do
  describe 'call' do
    subject { described_class.new.call('facebook') }
    let(:url) { "#{Rails.application.credentials.feed_base_url}/facebook" }

    it 'returns correct RestClient::Resource object url' do
      expect(subject.url).to eq url
    end
  end
end
