require "between/id"
require "between/key"

module Between
  class Parser
    attr_reader :model
    attr_reader :data

    def initialize model, data = nil
      @data  = data || {}
      @model = model
    end

    def id name, options = nil
      ID.new(name, options).parse model, data
    end

    def key name, options = nil, &block
      Key.new(name, options).parse model, data, &block
    end
  end
end
