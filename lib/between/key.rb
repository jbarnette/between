module Between

  # Internal.

  class Key
    def initialize name, options = nil
      @default = options && options[:default]
      @name    = name.to_s
      @source  = options && options[:from] && options[:from].to_s
      @value   = options && options[:value]
    end

    def exists? data
      value(data) || data.include?(source) || @default
    end

    def name
      @name.end_with?("?") ? @name[0..-2] : @name
    end

    def parse context, data, &block
      value = self.value data, &block
      context.set target, value if exists?(data)

      value
    end

    def source
      @source || name
    end

    def target
      name.intern
    end

    def value data, &block
      return @value if @value

      provided = data[source]
      provided = block[provided] if !provided.nil? && block

      provided || @default
    end
  end
end
