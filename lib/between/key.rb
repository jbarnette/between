module Between

  # Internal.

  class Key
    def initialize name, context, data, options = nil
      name = name.to_s # 1.8
      name = name[0..-2] if name.end_with? "?"

      @context = context
      @data    = data
      @default = options && options[:default]

      # The actual source key. Cache whether or not the calculated key
      # actually exists in the data.

      @source  = (options && options[:from]) || name
      @source  = @source.to_s unless @data.include? @source

      @target  = name.intern
      @value   = (options && options[:value]) || @data[@source] || @default
      @exists  = @value || @data.include?(@source) || @default
    end

    def exists?
      @exists
    end

    def set
      @context.set @target, @value

      @value
    end
  end
end
