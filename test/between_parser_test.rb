require "between/test"
require "between/parser"

describe Between::Parser do
  it "is initialized with a context and data" do
    p = Between::Parser.new :context, "foo" => "bar"

    assert_equal :context, p.context
    assert_equal 1, p.data.size
  end

  it "defaults to an empty Hash if data is missing" do
    p = Between::Parser.new :context
    assert_equal Hash.new, p.data
  end

  describe :id do
    it "extracts name and sets it as name_id on the context" do
      ctx = mock { expects(:set).with :foo_id, 42 }
      p   = Between::Parser.new ctx, "foo" => 42

      assert_equal 42, p.id(:foo)
    end

    it "passes through names ending in _id unchanged" do
      ctx = mock { expects(:set).with :foo_id, 42 }
      p   = Between::Parser.new ctx, "foo_id" => 42

      assert_equal 42, p.id(:foo_id)
    end
  end

  describe :key do
    it "extracts a value and sets it on the context" do
      ctx = mock { expects(:set).with :foo, "bar" }
      p   = Between::Parser.new ctx, "foo" => "bar"

      assert_equal "bar", p.key(:foo)
    end

    it "won't set if the key doesn't exist in data" do
      p = Between::Parser.new mock
      p.key :foo
    end

    it "removes trailing ? from predicates" do
      ctx = mock { expects(:set).with :foo, true }
      p   = Between::Parser.new ctx, "foo" => true

      assert p.key :foo?
    end

    it "can specify a completely different source name" do
      ctx = mock { expects(:set).with :foo, "bar" }
      p   = Between::Parser.new ctx, "baz" => "bar"

      assert_equal "bar", p.key(:foo, :from => :baz)
    end

    it "can specify an explicit override value" do
      ctx = mock { expects(:set).with :foo, "bar" }
      p   = Between::Parser.new ctx, "foo" => "baz"

      assert_equal "bar", p.key(:foo, :value => "bar")
    end

    it "can specify a default value" do
      ctx = mock { expects(:set).with :foo, "bar" }
      p   = Between::Parser.new ctx

      assert_equal "bar", p.key(:foo, :default => "bar")
    end

    it "returns the value set on the context" do
      ctx = stub :set
      p   = Between::Parser.new ctx, "foo" => "bar"

      assert_equal "bar", p.key(:foo)
    end

    it "takes a block to transform provided values" do
      ctx = stub :set
      p   = Between::Parser.new ctx, "foo" => "bar"

      assert_equal "BAR", p.key(:foo) { |v| v.upcase  }
    end
  end
end
