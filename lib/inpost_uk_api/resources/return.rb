module InPostUKAPI
  class Return < Base
    add_retailer_prefix_option
    self.prefix = '/v4/customers/:retailer/returns/v2'
    self.element_name = ''

    DEFAULT_ATTRS = {
      sender_email: 'customer_email@inpost.co.uk',
      sender_phone: '7999999999',
      size: 'A',
      customer_reference: 'customer reference number',
      show_quick_send_code: 'true'
    }
  end
end
