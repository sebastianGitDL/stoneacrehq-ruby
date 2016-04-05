module StoneacreHq
  class Token

    def initialize
      @conn = Faraday.new(
        :url => (StoneacreHq.config[:production] ? PRODUCTION_URL : DEVELOPMENT_URL ),
        :ssl => { :verify => StoneacreHq.config[:production] }
      ) do |builder|
        builder.request :json
        builder.response :mashify
        builder.response :json, :content_type => /\bjson$/
        builder.adapter  Faraday.default_adapter 
      end
    end

    def create
      @conn.post TOKEN_URL, {
        email: StoneacreHq.config[:username],
        password: StoneacreHq.config[:password] 
      }
    end
  end
end