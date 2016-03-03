module StoneacreHq
  class ClubCashTransaction
    #
    # More API information at https://dev.affinitystop.com:3000/doc/Api/ClubCashTransactionController.html
    #
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

    ##
    # Submits a club cash transaction.
    # This method adds or deducts an specific amount of club cash on a member. In case you want to add club cash, the amount value has to be a positive number, while if you want to remove club cash, the amount value has to be negative. Have in mind that in order to use this feature, member's club must allow club cash transaction within it.  
    def create(member_id, amount, description = '')
      post_message = { 
        api_key: StoneacreHq.config[:api_key], 
        club_cash_transaction: { 
          amount: amount, 
          description: description
        } 
      }
      @conn.post MEMBER_URL+"/"+member_id.to_s+"/club_cash_transaction", post_message
    end
  end
end
