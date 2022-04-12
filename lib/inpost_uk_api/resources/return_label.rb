module InPostUKAPI
  class ReturnLabel < Base
    self.prefix = '/v4/returns/v2/:tracking_id/sticker'
    self.element_name = ''

    def self.find(tracking_id)
      response = connection.get(collection_path(tracking_id: tracking_id))
      response_body = JSON.parse(response.body)
      if response_body['status_code'] == 404
        raise ActiveResource::ResourceNotFound.new(response, response_body['message'])
      end
    rescue JSON::ParserError => e
      response.body
    end
  end
end
