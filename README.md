<h1> StoneacreHq </h1>

StoneacreHQ API ruby gem 

gem build stoneacre_hq.gemspec 
gem install ../stoneacrehq-ruby/stoneacre_hq-0.0.1.gem 

<h2> Contributing </h2>

The source code is hosted at [GitHub](http://github.com/stoneacre/active_merchant), and can be fetched using:

```
 git clone git@github.com/stoneacre/stoneacrehq-ruby
```

Please see the [ActiveMerchant Guide to Contributing](http://github.com/stoneacre/stoneacrehq-ruby/wikis/contributing) for
information on extending this gem.

Please don't touch the CHANGELOG in your pull requests, we'll add the appropriate CHANGELOG entries
at release time.

<h2> Synopsis: </h2>

```
 StoneacreHq.config(:username => 'myuser', :password => 'mypass')
 or
 StoneacreHq.config(:api_key => 'my_token')
```

<h2> Install </h2>

In your Gemfile, add:

```
 gem 'stoneacre_hq', :git => 'git@github.com:stoneacre/stoneacrehq-ruby.git'
```

and run $ bundle install.

<h2> Some examples </h2>

```
 # Initializing Member module
 StoneacreHq.config[:api_key] = '3v4L18ofdJyde8mKh5DQ'
 member = StoneacreHq::Member.new

 # Creating a new user
 member_data = {first_name:"alice", last_name:"brennan", address:"SomeSt", city:"Dresden", state:"AL", gender:"", zip:"12345", phone_country_code:"1", phone_area_code:"123", phone_local_number:"1123", birth_date:"1989-09-03", email:"alice98@brennan.com", country:"US", prospect_id:"deadbeef", terms_of_membership_id:"198"}
 campaign_data = {enrollment_amount:"0.0", product_sku:"KIT-CARD", landing_url:"http://www.google.com", mega_channel:"super channel", marketing_code:"marketing code", fulfillment_code:"1", ip_address:"192.168.1.1", user_agent:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537..."}
 credit_card_data = {number:"371449635398431", expire_month:"2", expire_year:"2018"} 
 response = member.create(member_data, credit_card_data, campaign_data)
 response.body
 => #<Hashie::Mash autologin_url="" code="000" member_id=11349954888 message="Member enrolled successfully $0.0 on TOM(198) -re43-" status="provisional">

 # Fetching user's profile. (https://dev.affinitystop.com:3000/doc/Api/MembersController.html#_api_v1_members__id_profile__POST_)
 response = member.profile(11349954845)
 response.body
 => #<Hashie::Mash code="000" credit_card=#<Hashie::Mash expire_month=5 expire_year=2020 last_4_digits="4242"> current_membership=#<Hashie::Mash cancel_date="" join_date="2016-03-02T12:23:25-05:00" status="active" terms_of_membership_id=37> member=#<Hashie::Mash address="address" bill_date="2017-03-02T12:23:25-05:00" birth_date=nil blacklisted=false city="city" email="sonia+341111451@xagax.com" external_id=nil first_name="downgrade" gender=nil last_name="sactest" member_group_type=nil member_since_date="2016-02-23T08:48:56-05:00" phone_area_code=123 phone_country_code=1 phone_local_number=1233 preferences=nil state="IN" type_of_phone_number="" wrong_address=nil wrong_phone_number=nil zip="13254">> 
```

<h2> How to test? </h2>

```
 rspec spec/remote_test.rb 
```
