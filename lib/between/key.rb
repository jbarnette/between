module Between

  # Internal.

  class Key
    def initialize name, context, data, options = nil
      name = name.to_s # 1.8
      name = name[0..-2] if name.end_with? "?"

      @context = context
      @data    = data
      @source  = (options && options[:from]) || name
      @target  = name.intern
    end

    def get
      @data[@source] || @data[@source.to_s]
    end

    def exists?
      @data.include?(@source) || @data.include?(@source.to_s)
    end

    def set
      @context.set @target, get
    end
  end
end
