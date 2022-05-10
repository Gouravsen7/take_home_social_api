class SocialFeedService
  attr_reader :data, :errors

  DATA_MAPPINGS = {
    facebook: 'status',
    instagram: 'photo',
    twitter: 'tweet'
  }.freeze

  BASE_URL = Rails.application.credentials.feed_base_url
  TIMEOUT_SECONDS = 15
  OPEN_TIMEOUT_SECONDS = 5

  def initialize
    @data = {}
    @errors = []
    @client = Client.new
  end

  def call
    begin
      threads = []
      DATA_MAPPINGS.each do |platform, filter|
        threads << Thread.new do
          response = get(platform, filter)
          @data[platform] = result(response)
        end
      end
      threads.each(&:join)
    rescue StandardError => e
      @errors << e
    end
    log_errors if errors.present?
    errors.blank?
  end

  private

  def get(platform, filter)
    begin
      response = @client.call(platform).get
      if response.code == 200
        { data: JSON.parse(response.body).map { |res| res[filter] } }
      else
        { error_message: I18n.t('errors.messages.something_wrong') }
      end
    rescue RestClient::Exceptions::Timeout
      { error_message: I18n.t('errors.messages.connection_timeout') }
    rescue RestClient::Exception
      { error_message: I18n.t('errors.messages.something_wrong') }
    end
  end

  def result(response)
    return response[:data] if response[:error_message].blank?

    [{ error_message: response[:error_message] }]
  end

  def log_errors
    Rails.logger.info errors
  end
end

