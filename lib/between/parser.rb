require "between/key"

module Between
  class Parser
    attr_reader :context
    attr_reader :data

    def initialize context, data = nil
      @context = context
      @data    = data || {}
    end

    def key name, options = nil
      Key.new(name, options).parse context, data
    end
  end
end
