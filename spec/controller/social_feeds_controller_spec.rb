require 'rails_helper'

RSpec.describe SocialFeedsController, type: :controller do
  describe 'GET index' do
    before do
      expect_any_instance_of(SocialFeedService).to receive(:call).once.and_return(feed_response)
      get :index
    end

    context 'when result is success' do
      let(:data) do
        {
          facebook: %w[status1 status2],
          instagram: %w[photo1 photo2],
          twitter: %w[tweet1 tweet2]
        }.to_json
      end
      let(:feed_response) do
        double(data: data, errors: {})
      end

      it 'returns fetched data' do
        expect(response.body).to eq data
      end

      it 'responds with 200' do
        expect(response.code).to eq '200'
      end
    end

    context 'when result is failure' do
      let(:error) { { error_message: 'Something went wrong.' }.to_json }
      let(:feed_response) { double(errors: error) }

      it 'returns error' do
        expect(response.body).to eq error
      end

      it 'responds with 500' do
        expect(response.code).to eq '500'
      end
    end
  end
end
