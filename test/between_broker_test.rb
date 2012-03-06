require "between/test"
require "between/broker"

describe Between::Broker do
  it "is initialized with a model and an optional context" do
    b = Between::Broker.new :model, :context

    assert_equal :model, b.model
    assert_equal :context, b.context
  end

  it "properly reuses context and sets parent if context is a broker" do
    p = Between::Broker.new mock("model"), mock("context")
    c = Between::Broker.new mock("model"), p

    assert_same p.context, c.context
    assert_same p, c.parent

    assert c.child?
  end

  it "can check to see if it's nested inside the broker for a class" do
    p = Between::Broker.new :model
    c = Between::Broker.new mock("model"), p

    refute p.inside? Symbol
    assert c.inside? Symbol
  end

  it "can check to see if it's nested inside a specific model" do
    p = Between::Broker.new :model
    c = Between::Broker.new mock("model"), p

    refute c.inside? :model!
    assert c.inside? :model
  end

  it "can check to see if it's nested inside based on arbitrary criteria" do
    p = Between::Broker.new 42
    c = Between::Broker.new mock("model"), p

    refute c.inside? { |m| m % 2 == 1 }
    assert c.inside? { |m| m % 2 == 0 }
  end

  it "parses by creating a parser and calling the custom impl" do
    b = Between::Broker.new mock("model")

    data   = { "foo" => "bar" }
    parser = mock "parser"

    b.expects(:parser).with(data).returns parser
    b.expects(:parse!).with parser

    b.parse data
  end

  it "raises on parse! since subclasses must implement" do
    assert_raises NotImplementedError do
      Between::Broker.new(mock).parse! mock
    end
  end
end
