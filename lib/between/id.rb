require "between/attr"

module Between
  class ID < Attr
    def target
      (name.end_with?("_id") ? name : "#{name}_id").intern
    end
  end
end
