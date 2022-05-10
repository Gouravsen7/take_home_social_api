class Client
  BASE_URL = Rails.application.credentials.feed_base_url
  TIMEOUT_SECONDS = 15
  OPEN_TIMEOUT_SECONDS = 5

  def initialize(base_url: BASE_URL, timeout: TIMEOUT_SECONDS, open_timeout: OPEN_TIMEOUT_SECONDS)
    @base_url = base_url
    @timeout = timeout
    @open_timeout = open_timeout
  end

  def call(suffix)
    url = "#{@base_url}/#{suffix}"
    RestClient::Resource.new(url, timeout: @timeout, open_timeout: @open_timeout)
  end
end
