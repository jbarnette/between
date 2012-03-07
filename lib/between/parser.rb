require "between/id"
require "between/attr"

module Between
  class Parser
    attr_reader :broker
    attr_reader :data

    def initialize broker, data = nil
      @broker = broker
      @data   = data || {}
    end

    def attr name, options = nil, &block
      Attr.new(name, options).parse broker, data, &block
    end

    def id name, options = nil
      ID.new(name, options).parse broker, data
    end
  end
end
