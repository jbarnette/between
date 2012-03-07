require "between/test"
require "between"
require "json"

# The tests in this file are intended to be lumpy, ungainly things
# extracted from Real Life. Integrationish, I guess.

describe Between do
  it "can deal with simple attrs" do
    json = JSON.parse File.read "test/fixtures/simple-keys.json"

    ctx = mock "broker" do
      expects(:set).with :bool,   true
      expects(:set).with :fixnum, 42
      expects(:set).with :float,  3.14
      expects(:set).with :null,   nil
      expects(:set).with :fk_id,  24
      expects(:set).with :string, "Hello, world!"
    end

    p = Between::Parser.new ctx, json

    p.attr :bool
    p.attr :fixnum
    p.id   :fk
    p.attr :float
    p.attr :string
    p.attr :null
  end
end
