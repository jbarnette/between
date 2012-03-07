require "between/test"
require "between"
require "json"

# The tests in this file are intended to be lumpy, ungainly things
# extracted from Real Life. Integrationish, I guess.

describe Between do
  it "can deal with simple attrs" do
    json = JSON.parse File.read "test/fixtures/simple-keys.json"

    model = mock "model" do
      expects(:bool=).with   true
      expects(:fixnum=).with 42
      expects(:float=).with  3.14
      expects(:null=).with   nil
      expects(:fk_id=).with  24
      expects(:string=).with "Hello, world!"
    end

    broker = Between::Broker.new model

    def broker.parse! p
      p.attr :bool
      p.attr :fixnum
      p.id   :fk
      p.attr :float
      p.attr :string
      p.attr :null
    end

    broker.parse json
  end
end
