require 'zeitwerk'
require_relative 'config'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  'inpost_uk_api' => 'InPostUKAPI'
)
loader.push_dir('./lib')
loader.collapse('./lib/inpost_uk_api/resources')
loader.ignore("#{__dir__}/config.rb")
loader.enable_reloading
# loader.log!
loader.setup

$__inpost_uk_api_loader__ = loader

def reload!
  $__inpost_uk_api_loader__.reload
  set_config
  true
end
