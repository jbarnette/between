require "between/test"
require "between"
require "yajl"

# The tests in this file are intended to be lumpy, ungainly things
# extracted from Real Life. Integrationish, I guess.

describe Between do
  it "can deal with simple keys" do
    json = Yajl::Parser.parse File.read "test/fixtures/simple-keys.json"

    ctx = mock do
      expects(:set).with :bool,   true
      expects(:set).with :fixnum, 42
      expects(:set).with :float,  3.14
      expects(:set).with :null,   nil
      expects(:set).with :string, "Hello, world!"
    end

    p = Between::Parser.new ctx, json

    p.key :bool
    p.key :fixnum
    p.key :float
    p.key :string
    p.key :null
  end
end
