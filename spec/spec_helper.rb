require 'bundler'
Bundler.require(:default, :test)

require 'stoneacre_hq'
require 'Faker'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

end