# encoding: utf-8

require 'github_api/core_ext/hash'

module Github
  class ApiFactory

    # Instantiates a new github api object
    #
    def self.new(klass, options={})
      return create_instance(klass, options) if klass
      raise ArgumentError, 'must provide API class to be instantiated'
    end

    # Passes configuration options to instantiated class
    #
    def self.create_instance(klass, options)
      options.symbolize_keys!
      convert_to_constant(klass.to_s).new options
    end

    # Convert name to constant
    #
    def self.convert_to_constant(classes)
      classes.split('::').inject(Github) do |constant, klass|
        constant.const_get klass
      end
    end

  end # ApiFactory
end # Github
