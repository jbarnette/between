require "between/parser"

module Between
  class Broker
    attr_reader :context
    attr_reader :parent
    attr_reader :model

    # Public: Initialize a new broker.

    def initialize model, context = nil
      @context = context
      @model   = model

      if Broker === context
        @parent  = context
        @context = @parent.context
      end
    end

    # Public: Does this broker have a parent?

    def child?
      !!parent
    end

    # Public: Do any of this broker's ancestors match?

    def inside? criteria = nil, &block
      block ||= lambda { |m| criteria === parent.model }
      child? && (block[parent.model] || parent.inside?(&block))
    end

    # Public: Parse data and apply to the model.

    def parse data
      parse! parser data
    end

    # Internal: Create a parser for data.

    def parser data
      Between::Parser.new self, data
    end

    # Internal: Parse data with parser. Subclasses must implement.

    def parse! parser
      raise NotImplementedError, "Implement #{self.class.name}#parse!"
    end

    # Internal: Set a value on this broker's model.

    def set name, value
      model.send "#{name}=", value
    end
  end
end
