module StoneacreHq
  class Product
    # Constructs a Product.
    #
    # More API information at https://dev.stoneacrehq.com:3000/doc/Api/ProductsController.html
    #
    def initialize
      @conn = Faraday.new(
        :url => (StoneacreHq.config[:production] ? PRODUCTION_URL : DEVELOPMENT_URL ),
        :ssl => { :verify => StoneacreHq.config[:production] }
      ) 
    end
    
    ##
    # 
    #
    def find_all_by_product_skus(club_id, skus = [])
      @conn.post PRODUCT_URL+'/get_list_of_stock', { api_key: StoneacreHq.config[:api_key], club_id: club_id, sku: skus }
    end
  end
end
