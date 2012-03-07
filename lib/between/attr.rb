module Between

  # Internal.

  class Attr
    def initialize name, options = nil
      @default  = options && options[:default]
      @name     = name.to_s
      @presence = options && FalseClass === options[:blank]
      @source   = options && options[:from] && options[:from].to_s
      @value    = options && options[:value]
    end

    # A value is blank if this attr requires presence, it's nil,
    # responds to "empty?" with a true value, is a String that matches
    # an anchored whitespace-only regex, or responds to "blank?" with
    # a true value. This is ugly. Alternatives are most welcome.

    def blank? value
      @presence &&
        (value.nil? ||
         (value.respond_to?(:empty?) && value.empty?) ||
         ((String === value) && /\A\s+\Z/ =~ value) ||
         (value.respond_to?(:blank?) && value.blank?))
    end

    def parseable? data
      return false if blank? value(data)
      value(data) || data.include?(source) || @default
    end

    def name
      @name.end_with?("?") ? @name[0..-2] : @name
    end

    def parse broker, data, &block
      value = self.value data, &block

      if parseable? data
        broker.set target, value
        value
      end
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
