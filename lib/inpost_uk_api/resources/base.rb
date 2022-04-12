module InPostUKAPI
  class Base < ActiveResource::Base
    self.include_format_in_path = false
    self.auth_type = :bearer

    class << self
      # _retailer is a internal class variable to make sure that all instances
      # inherit from Base class share the same variable.
      threadsafe_attribute(:_retailer)

      def retailer
        if superclass == ActiveResource::Base
          if _retailer_defined?
            _retailer
          else
            _retailer = InPostUKAPI.config.retailer
          end
        else
          superclass.retailer
        end
      end

      def retailer=(value)
        if superclass == ActiveResource::Base
          self._retailer = value
        else
          superclass.retailer = value
        end
      end

      # Helper to add retailer prefix option when the resource needs it
      def add_retailer_prefix_option
        define_singleton_method('check_prefix_options') do |prefix_options|
          prefix_options[:retailer] = retailer
          super(prefix_options)
        end
      end

      def with_account(account_hash)
        cached_retailer = retailer
        cached_api_token = connection.bearer_token
        self.retailer = account_hash[:retailer]
        connection.bearer_token = account_hash[:api_token]
        yield
      ensure
        self.retailer = cached_retailer
        connection.bearer_token = cached_api_token
      end
    end

    def initialize(attributes = {}, persisted = false)
      attributes = self.class::DEFAULT_ATTRS.merge(attributes) if defined?(self.class::DEFAULT_ATTRS)
      super
    end
  end
end
