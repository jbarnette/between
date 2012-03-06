require "between/test"
require "between"
require "json"

# The tests in this file are intended to be lumpy, ungainly things
# extracted from Real Life. Integrationish, I guess.

describe Between do
  it "can deal with simple keys" do
    json = JSON.parse File.read "test/fixtures/simple-keys.json"

    ctx = mock do
      expects(:bool=).with   true
      expects(:fixnum=).with 42
      expects(:float=).with  3.14
      expects(:null=).with   nil
      expects(:fk_id=).with  24
      expects(:string=).with "Hello, world!"
    end

    p = Between::Parser.new ctx, json

    p.key :bool
    p.key :fixnum
    p.id  :fk
    p.key :float
    p.key :string
    p.key :null
  end
end
