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
      key = Key.new name, options
      return unless key.exists? data

      key.parse context, data
    end
  end
end
