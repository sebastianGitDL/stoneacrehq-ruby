require 'stoneacre_hq/config'
require 'faraday'

module StoneacreHq
  DEVELOPMENT_URL = 'https://dev.affinitystop.com:3000/'.freeze
  PRODUCTION_URL = 'https://api.stoneacrehq.com/'.freeze
  MEMBER_URL = '/api/v1/members'.freeze
  PRODUCT_URL = '/api/v1/products'.freeze
  PROSPECT_URL = '/api/v1/prospects'.freeze

  autoload :Member, 'stoneacre_hq/member'
  autoload :Prospect, 'stoneacre_hq/prospect'
  autoload :Product, 'stoneacre_hq/product'
end
