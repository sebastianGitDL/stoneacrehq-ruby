require 'spec_helper'
include StoneacreHq

describe Member do

  context 'testing to development' do

    before(:each) do
      # set the following values in order to test:
      api_key = ''
      terms_of_membership_id = 1
      club_id = 1
      ####
      StoneacreHq.config(:api_key => api_key, :production => false) 
    end

    def create_member
      {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        address: Faker::Address.street_address,
        city: Faker::Address.city,
        zip: Faker::Address.zip,
        state: "AL",
        email: Faker::Internet.email,
        type_of_phone_number: 'Home',
        phone_country_code: 123,
        phone_area_code: 123,
        phone_local_number: 1234,
        birth_date: DateTime.now,
        terms_of_membership_id: terms_of_membership_id,
        gender: "M",
        country: "US"
      }
    end

    def create_credit_card
      {
        expire_month: (Date.today + 30).month,
        expire_year: (Date.today + 365).year,
        number: "4012301230123010"
      }
    end

    def create_campaign
      {
        enrollment_amount: 0.50,
        product_sku: Faker::Lorem.word,
        product_description: Faker::Lorem.word,
        mega_channel: Faker::Lorem.word,
        marketing_code: Faker::Lorem.word,
        fulfillment_code: Faker::Lorem.word,
        ip_address: Faker::Internet.ip_v4_address,
        user_agent: Faker::Lorem.word,
        referral_host: Faker::Internet.domain_name,
        referral_parameters: Faker::Lorem.word,
        referral_path: Faker::Lorem.word,
        user_id: Faker::Lorem.word,
        landing_url: Faker::Internet.url,
        preferences: Faker::Lorem.word,
        cookie_value: Faker::Lorem.word,
        cookie_set: Faker::Lorem.word,
        campaign_medium: Faker::Lorem.word,
        campaign_description: Faker::Lorem.word,
        campaign_medium_version: Faker::Lorem.word,
        joint: true
      }
    end

    it 'create a member without prospect id' do
	    client = StoneacreHq::Member.new
	    member_data, credit_card_data, campaign_data = create_member, create_credit_card, create_campaign
	    response = client.create(member_data, credit_card_data, campaign_data)
      response.status.should eql 200 
      response.body
    end

    it "retrieve products" do
      client = StoneacreHq::Product.new
      response = client.find_all_by_product_skus(club_id, ['KIT-CARD,DOES-NOT-EXIST'])
      response.status.should eql 200 
    end
  end

end
