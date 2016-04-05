module StoneacreHq
  class Member < StoneacreHq::Base
   
    ##
    # Submits a member to be created. This method will call the method enroll on member model. It will validate
    # the member's data (including its credit card) and, in case it is correct, it will create and save the member.
    # It will also send a welcome email and charge the enrollment to the member's credit card.  
    def create(member_data = {}, credit_card_data = {}, campaign_data = {})
      prospect_id = nil
      unless member_data[:prospect_id]
        prospect = Prospect.new 
        answer = prospect.create(member_data, campaign_data)
        answer = JSON.parse answer.body
        prospect_id = answer['prospect_id'] if answer['code'] == "000"
      end
      member_message = {
        first_name: member_data[:first_name], 
        last_name: member_data[:last_name], 
        address: member_data[:address], 
        city: member_data[:city], 
        state: member_data[:state], 
        zip: member_data[:zip], 
        country: member_data[:country], 
        phone_country_code: member_data[:phone_country_code], 
        phone_area_code: member_data[:phone_area_code], 
        phone_local_number: member_data[:phone_local_number], 
        email: member_data[:email], 
        gender: member_data[:gender], 
        type_of_phone_number: member_data[:type_of_phone_number], 
        external_id: member_data[:external_id], 
        terms_of_membership_id: member_data[:terms_of_membership_id], 
        birth_date: member_data[:birth_date], 
        prospect_id: prospect_id, 

        enrollment_amount: campaign_data[:enrollment_amount], 
        product_sku: campaign_data[:product_sku], 
        product_description: campaign_data[:product_description], 
        mega_channel: campaign_data[:mega_channel], 
        marketing_code: campaign_data[:marketing_code], 
        fulfillment_code: campaign_data[:fulfillment_code], 
        ip_address: campaign_data[:ip_address], 
        user_agent: campaign_data[:user_agent], 
        referral_host: campaign_data[:referral_host], 
        referral_parameters: campaign_data[:referral_parameters], 
        referral_path: campaign_data[:referral_path], 
        user_id: campaign_data[:user_id], 
        landing_url: campaign_data[:landing_url], 
        preferences: campaign_data[:preferences], 
        cookie_value: campaign_data[:cookie_value], 
        cookie_set: campaign_data[:cookie_set], 
        campaign_medium: campaign_data[:campaign_medium], 
        campaign_description: campaign_data[:campaign_description], 
        campaign_medium_version: campaign_data[:campaign_medium_version], 
        joint: campaign_data[:joint]
      }

      if credit_card_data
        member_message.merge!({
                            credit_card: {
                              number: credit_card_data[:number], 
                              expire_month: credit_card_data[:expire_month], 
                              expire_year: credit_card_data[:expire_year]
                            } 
                          })
      end

      post_message = { 
        api_key: StoneacreHq.config[:api_key], 
        member: member_message 
      }.merge(credit_card_data.nil? ? { 
                setter: { 
                  cc_blank: true
                } 
              } : {})

      @conn.post MEMBER_URL, post_message
    end

    ##
    # Updates member's data. You may only send fields that has change only. 
    # In case a credit_card field has been change, make sure to send all credit cards fields again 
    # (even the ones that has not change). 
    #
    def update(member_data = {}, credit_card_data = {})
      put_message = {
        api_key: StoneacreHq.config[:api_key],
        first_name: member_data[:first_name], 
        last_name: member_data[:last_name], 
        address: member_data[:address], 
        city: member_data[:city], 
        state: member_data[:state], 
        zip: member_data[:zip], 
        country: member_data[:country], 
        phone_country_code: member_data[:phone_country_code], 
        phone_area_code: member_data[:phone_area_code], 
        phone_local_number: member_data[:phone_local_number], 
        email: member_data[:email], 
        gender: member_data[:gender], 
        type_of_phone_number: member_data[:type_of_phone_number], 
        external_id: member_data[:external_id], 
        member_group_type_id: member_data[:member_group_type_id], 
        api_id: member_data[:api_id], 
        preferences: member_data[:preferences], 
        birth_date: member_data[:birth_date]
      }

      if credit_card_data
        put_message.merge!({ credit_card: {
                              number: credit_card_data[:number], 
                              expire_month: credit_card_data[:expire_month], 
                              expire_year: credit_card_data[:expire_year]
                            } })
      end
      @conn.put MEMBER_URL+'/'+member_data[:id].to_s, put_message
    end

    ##
    # Returns information related to member's information, credit card, current membership and enrollment information.
    #
    def profile(member_id)
      @conn.post MEMBER_URL+'/'+member_id.to_s+'/profile', { api_key: StoneacreHq.config[:api_key] }
    end

    ##
    # Change actual subscription plans related to a member, with the option to prorate it.
    #
    def update_terms_of_membership(id_or_email, terms_of_membership_id, credit_card_data = {}, prorated = true)
      post_message = {
        api_key: StoneacreHq.config[:api_key],
        id_or_email: id_or_email,
        terms_of_membership_id: terms_of_membership_id,
        prorated: prorated
      }

      if credit_card_data
        post_message.merge!( credit_card: {
          number: credit_card_data[:number],
          expire_year: credit_card_data[:expire_year],
          expire_month: credit_card_data[:expire_month],
          set_active: (credit_card_data[:set_active].nil? ? true : credit_card_data[:set_active])
        })
      end

      @conn.post MEMBER_URL+'/update_terms_of_membership', post_message
    end

  end
end