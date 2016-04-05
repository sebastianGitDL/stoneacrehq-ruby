module StoneacreHq
  class Prospect < StoneacreHq::Base
    
    ##
    # Creates prospect with data that we recieve. We don't validate this data.
    #
    def create(member_data = {}, campaign_data = {})
      @conn.post PROSPECT_URL, {
        api_key: StoneacreHq.config[:api_key],
        prospect: {
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
            terms_of_membership_id: member_data[:terms_of_membership_id], 
            birth_date: member_data[:birth_date], 
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
            source: campaign_data[:source], 
            joint: campaign_data[:joint]
        }
      }
    end
  end
end
