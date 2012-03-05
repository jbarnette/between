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
      key = Key.new name, context, data, options
      return unless key.exists?

      key.parse
    end
  end
end
