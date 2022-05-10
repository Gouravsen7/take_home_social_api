class SocialFeedsController < ApplicationController
  def index
    feed_response = SocialFeedService.new.call

    if feed_response.errors.blank?
      render json: feed_response.data, status: :ok
    else
      render json: { error_message: 'Something went wrong.' }, status: 500
    end
  end
end
