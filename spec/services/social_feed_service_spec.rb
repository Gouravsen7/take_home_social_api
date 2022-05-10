require 'rails_helper'

describe SocialFeedService do
  describe '#get' do
    subject { described_class.new.send(:get, platform, filter) }
    let(:client_response) { double(get: response) }

    before do
      expect_any_instance_of(Client).to receive(:call).once.and_return(client_response)
    end

    context 'when response code is 200' do
      let(:data) do
        {
          facebook: %w[status1 status2],
          instagram: %w[photo1 photo2],
          twitter: %w[tweet1 tweet2]
        }
      end
      let(:response) { double(code: 200, body: body.to_json) }

      context '#facebook' do
        let(:platform) { :facebook }
        let(:filter) { 'status' }
        let(:body) { [{ name: 'name1', status: 'status1' }, { name: 'name2', status: 'status2' }] }

        it 'returns right data in response' do
          expect(subject[:data]).to eq data[:facebook]
        end
      end

      context '#instagram' do
        let(:platform) { :instagram }
        let(:filter) { 'photo' }
        let(:body) { [{ profilename: 'profilename1', photo: 'photo1' }, { profilename: 'profilename2', photo: 'photo2' }] }

        it 'returns right data in response' do
          expect(subject[:data]).to eq data[:instagram]
        end
      end

      context '#twitter' do
        let(:platform) { :twitter }
        let(:filter) { 'tweet' }
        let(:body) { [{ username: 'username1', tweet: 'tweet1' }, { username: 'username2', tweet: 'tweet2' }] }

        it 'returns right data in response' do
          expect(subject[:data]).to eq data[:twitter]
        end
      end
    end

    context 'when response code is not 200' do
      let(:response) { double(code: 404) }
      let(:platform) { :facebook }
      let(:filter) { 'status' }

      it 'returns error message in response' do
        expect(subject[:error_message]).to eq 'Something went wrong.'
      end
    end
  end
end
