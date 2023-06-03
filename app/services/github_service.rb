class GithubService
    BASE_URL = 'https://api.github.com'.freeze
  
    def initialize
      @conn = Faraday.new(url: BASE_URL) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end
  
    def search_user(login)
      
      response = @conn.get("/users/#{login}")
      return unless response.status == 200
  
      JSON.parse(response.body)
    end
end