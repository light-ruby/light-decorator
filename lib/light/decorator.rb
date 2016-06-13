require 'request_store'
require 'rails/railtie'
require 'active_support/concern'

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
    NOT_DELEGATABLE_METHODS = Kernel.methods + [:decorated?, :==, :===, :eql?, :equal?]
  end
end
