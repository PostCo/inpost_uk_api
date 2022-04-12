module InPostUKAPI
  class Configuration
    attr_accessor :site, :retailer
  end

  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
      after_configure
    end

    def after_configure
      InPostUKAPI::Base.site = config.site
      InPostUKAPI::Base.connection.bearer_token = config.api_token
    end
  end
end
