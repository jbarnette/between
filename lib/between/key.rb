module Between

  # Internal.

  class Key
    def initialize name, options = nil
      @default = options && options[:default]
      @name    = name.to_s
      @source  = options && options[:from] && options[:from].to_s
      @value   = options && options[:value]
    end

    def parseable? data
      value(data) || data.include?(source) || @default
    end

    def name
      @name.end_with?("?") ? @name[0..-2] : @name
    end

    def parse model, data, &block
      set model, value(data, &block) if parseable? data
    end

    # Internal: Set this key's `value` on `model` by calling a
    # `target=` method.

    def set model, value
      model.send "#{target}=", value

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
