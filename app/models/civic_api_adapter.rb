class CivicAPIAdapter

  include HTTParty

  base_uri 'https://www.googleapis.com/civicinfo/v2'

  def initialize
    @token = ENV["GOOGLE_CIVIC_API_KEY"]
  end

  def get_reps(address)
    @options = { query: { key: @token, address: address } }
    self.class.get('/representatives', @options)
  end
end
