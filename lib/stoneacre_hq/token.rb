module StoneacreHq
  class Token < StoneacreHq::Base

    def create
      @conn.post TOKEN_URL, {
        email: StoneacreHq.config[:username],
        password: StoneacreHq.config[:password] 
      }
    end
  end
end