require 'dotenv/load'

def set_config
  InPostUKAPI.configure do |config|
    config.site = ENV['SITE']
    config.retailer = ENV['RETAILER']
    config.api_token = ENV['API_TOKEN']
  end
end
