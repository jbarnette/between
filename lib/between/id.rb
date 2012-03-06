require "between/key"

module Between
  class ID < Key
    def target
      (name.end_with?("_id") ? name : "#{name}_id").intern
    end
  end
end
