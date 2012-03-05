module Between

  # Internal.

  class Key
    def initialize name, options = nil
      name = name.to_s # 1.8
      name = name[0..-2] if name.end_with? "?"

      @default = options && options[:default]
      @source  = options && options[:from] || name
      @target  = name.intern
      @value   = options && options[:value]
    end

    def exists? data
      value(data) || data.include?(@source) ||
        data.include?(@source.to_s) || @default
    end

    def parse context, data, &block
      value = self.value data, &block
      context.set @target, value if exists?(data)

      value
    end

    def value data, &block
      return @value if @value

      provided = data[@source] || data[@source.to_s]
      provided = block[provided] if !provided.nil? && block

      provided || @default
    end
  end
end
