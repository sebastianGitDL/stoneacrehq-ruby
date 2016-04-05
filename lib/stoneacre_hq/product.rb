module StoneacreHq
  class Product < StoneacreHq::Base
    
    ##
    # 
    #
    def find_all_by_product_skus(club_id, skus = [])
      @conn.post PRODUCT_URL+'/get_list_of_stock', { api_key: StoneacreHq.config[:api_key], club_id: club_id, sku: skus }
    end
  end
end
