module Between

  # Internal.

  class Key
    def initialize name, context, data, options = nil
      name = name.to_s # 1.8
      name = name[0..-2] if name.end_with? "?"

      @context = context
      @data    = data
      @default = options && options[:default]
      @source  = (options && options[:from]) || name
      @target  = name.intern
      @value   = options && options[:value]
    end

    def exists?
      !!(@value || @data.include?(@source) ||
         @data.include?(@source.to_s) || @default)
    end

    def set
      @context.set @target, value

      value
    end

    def value
      @value ||= @data[@source] || @data[@source.to_s] || @default
    end
  end
end
