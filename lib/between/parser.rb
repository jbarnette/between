require "between/id"
require "between/attr"

module Between
  class Parser
    attr_reader :model
    attr_reader :data

    def initialize model, data = nil
      @data  = data || {}
      @model = model
    end

    def attr name, options = nil, &block
      Attr.new(name, options).parse model, data, &block
    end

    def id name, options = nil
      ID.new(name, options).parse model, data
    end
  end
end
