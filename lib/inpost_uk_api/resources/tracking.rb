module InPostUKAPI
  class Tracking < ActiveResource::Base
    self.site = 'https://tracking.inpost.co.uk'
    self.prefix = '/api/v2.0/'
    self.include_format_in_path = false
    self.element_name = ''

    class << self
      def find(*args)
        # Handle the case when the response is an array when only 1 tracking number is passed
        # by set the request to at least 2 tracking numbers, then remove the fake one, "CS", afterwards
        args[0] += ';CS' if args[0].split(';').length == 1
        response = super
        response.attributes.delete('CS')
        response
      end

      def where(*args)
        find(*args)
      end
    end
  end
end
