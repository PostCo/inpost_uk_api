# InPostUKAPI
This is an unofficial Ruby API wrapper for `https://developers.inpost.co.uk/`
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inpost_uk_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install inpost_uk_api

## Usage
### Returns
#### Create a Returns Request
Doc: https://developers.inpost.co.uk/#operation/createReturns
```ruby
re = InPostUKAPI::Return.new(
    sender_email: "sender@postco.co",
    sender_phone: "7999999999",
    size: "A",
    customer_reference: "customer reference number",
    show_quick_send_code: "true"
)
re.save

re.id # => "CS0000000009778"
re.status # => "customer_delivering
```
#### Get Returns QR Code
Doc: https://developers.inpost.co.uk/#operation/getReturnsLabel
```ruby
label = InPostUKAPI::ReturnLabel.find("CS0000000009778")
label # => a pdf blob string

begin
    invalid_label = InPostUKAPI::ReturnLabel.find("CS00000000ABC")
rescue ActiveResource::ResourceNotFound => e
    e.response.body # => "{\"status_code\":404,\"error_code\":\"return_not_found\",\"message\":\"Return CS0000000009778d not found.\",\"errors\":{}}"

    # activeresource version >= 6.0.0
    e.message # => Return CS00000000ABC not found.

    # activeresource version < 6.0.0
    e.message # => Failed.  Response code = 200.  Response message = OK.    
end
```
### Request Tracking Data
This endpoint only available for PROD labels.

The tracking data you got might not be the right one if you are querying using the tracking id from the staging server.

Doc: https://developers.inpost.co.uk/#operation/getTracking
```ruby
tracking = InPostUKAPI::Tracking.find("CS0000000009778")
CS0000000009778_trackings = tracking.CS0000000009778
CS0000000009778_trackings.first.ts # => "29/03/2021 15:43:56pm"
CS0000000009778_trackings.first.description # => "Ready For Dispatch"

# Can query for multiple parcels by separating the ids by ";".
tracking = InPostUKAPI::Tracking.where("CS0000000009778;CS0000000009777;CSDDD")
CSDDD_trackings = tracking.CSDDD
CSDDD_trackings.error # => "No events found for consignment CSDDD"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Pending Endpoints
- [ ] [APM Locations API](https://developers.inpost.co.uk/#tag/APM-Locations-API)
   - [ ] [getAPMLocations](https://developers.inpost.co.uk/#operation/getAPMLocations)
- [ ] [Address to Locker Label Creation](https://developers.inpost.co.uk/#tag/Address-to-Locker-Label-Creation)
    - [ ] [Create Address to Locker Label](https://developers.inpost.co.uk/#operation/addressToLocker)
    - [ ] [Pay for Address to Locker Parcel](https://developers.inpost.co.uk/#operation/addressToLockerPayment)
    - [ ] [Get Address to Locker Parcel Label](https://developers.inpost.co.uk/#operation/getAddressToLockerLabel)
- [ ] [Locker to Address Label Creation](https://developers.inpost.co.uk/#tag/Locker-to-Address-Label-Creation)
    - [ ] [Create Locker to Address Label](https://developers.inpost.co.uk/#operation/lockerToAdddress)
    - [ ] [Pay for Locker to Address Parcel](https://developers.inpost.co.uk/#operation/lockerToAddressPayment)
    - [ ] [Get Locker to Address Parcel Label](https://developers.inpost.co.uk/#operation/getLockerToAddressLabel)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/postco/inpost_uk_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/postco/inpost_uk_api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the InPostUKAPI project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/postco/inpost_uk_api/blob/main/CODE_OF_CONDUCT.md).
