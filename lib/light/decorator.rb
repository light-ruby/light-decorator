require 'rails'
require 'active_record'
require 'request_store'

require 'light/decorator/version'
require 'light/decorator/exceptions'
require 'light/decorator/concerns/base'
require 'light/decorator/concerns/relation'
require 'light/decorator/concerns/associations/collection_proxy'
require 'light/decorator/railtie'
require 'light/decorator/view_context'
require 'light/decorator/decorate'

module Light
  module Decorator
    FORCE_DELEGATE = [:to_param].freeze
  end
end
