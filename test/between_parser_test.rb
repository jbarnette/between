require "between/test"
require "between/parser"

describe Between::Parser do
  it "is initialized with a model and data" do
    p = Between::Parser.new :model, "foo" => "bar"

    assert_equal :model, p.model
    assert_equal 1, p.data.size
  end

  it "defaults to an empty Hash if data is missing" do
    p = Between::Parser.new :model
    assert_equal Hash.new, p.data
  end

  describe :id do
    it "extracts name and sets it as name_id on the model" do
      m = mock { expects(:foo_id=).with 42 }
      p = Between::Parser.new m, "foo" => 42

      assert_equal 42, p.id(:foo)
    end

    it "passes through names ending in _id unchanged" do
      m = mock { expects(:foo_id=).with 42 }
      p = Between::Parser.new m, "foo_id" => 42

      assert_equal 42, p.id(:foo_id)
    end
  end

  describe :attr do
    it "extracts a value and sets it on the model" do
      m = mock { expects(:foo=).with "bar" }
      p = Between::Parser.new m, "foo" => "bar"

      assert_equal "bar", p.attr(:foo)
    end

    it "won't set if the attr doesn't exist in data" do
      p = Between::Parser.new mock
      p.attr :foo
    end

    it "removes trailing ? from predicates" do
      m = mock { expects(:foo=).with true }
      p = Between::Parser.new m, "foo" => true

      assert p.attr :foo?
    end

    it "can specify a completely different source name" do
      m = mock { expects(:foo=).with "bar" }
      p = Between::Parser.new m, "baz" => "bar"

      assert_equal "bar", p.attr(:foo, :from => :baz)
    end

    it "can specify an explicit override value" do
      m = mock { expects(:foo=).with "bar" }
      p = Between::Parser.new m, "foo" => "baz"

      assert_equal "bar", p.attr(:foo, :value => "bar")
    end

    it "can specify a default value" do
      m = mock { expects(:foo=).with "bar" }
      p = Between::Parser.new m

      assert_equal "bar", p.attr(:foo, :default => "bar")
    end

    it "returns the value set on the model" do
      m = stub :foo=
      p = Between::Parser.new m, "foo" => "bar"

      assert_equal "bar", p.attr(:foo)
    end

    it "takes a block to transform provided values" do
      m = stub :foo=
      p = Between::Parser.new m, "foo" => "bar"

      assert_equal "BAR", p.attr(:foo) { |v| v.upcase }
    end

    it "can ignore nil, empty, and blank attrs" do
      m = mock

      data = {
        "blankString" => "  \t",
        "emptyArray"  => [],
        "emptyHash"   => {},
        "emptyString" => "",
        "nil"         => nil,
      }

      p = Between::Parser.new m, data

      p.attr :blankString, :blank => false
      p.attr :emptyArray,  :blank => false
      p.attr :emptyHash,   :blank => false
      p.attr :emptyString, :blank => false
      p.attr :nil,         :blank => false
    end
  end
end
