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

  describe :key do
    it "asks the context to set the extracted value" do
      ctx = mock { expects(:set).with :foo, "bar" }
      p   = Between::Parser.new ctx, "foo" => "bar"

      p.key :foo
    end

    it "won't set if the key doesn't exist in data" do
      p = Between::Parser.new mock
      p.key :foo
    end

    it "removes trailing ? from predicates" do
      ctx = mock { expects(:set).with :foo, true }
      p   = Between::Parser.new ctx, "foo" => true

      p.key :foo?
    end

    it "can specify a completely different source name" do
      ctx = mock { expects(:set).with :foo, "bar" }
      p   = Between::Parser.new ctx, "baz" => "bar"

      p.key :foo, :from => :baz
    end
  end
end
