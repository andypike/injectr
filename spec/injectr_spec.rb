require 'spec_helper'

describe Injectr do
  it "allows classes to be registered" do
    container = Injectr.create_container do |c|
      c.register :foo, Foo
    end

    container.registry[:foo].should == Foo
  end

  context "given a registered key" do
    it "instantiates a class without any constructor parameters" do
      Injectr.create_container do |c|
        c.register :foo, Foo
      end

      Injectr.resolve(:foo).should be_a_kind_of(Foo)
    end

    it "instantiates a class with a required constructor parameter" do
      Injectr.create_container do |c|
        c.register :foo, Foo
        c.register :bar, Bar
      end

      bar = Injectr.resolve(:bar)
      bar.foo.should be_a_kind_of(Foo)
    end

    it "instantiates a class with multiple required constructor parameters 3 levels deep" do
      Injectr.create_container do |c|
        c.register :foo, Foo
        c.register :bar, Bar
        c.register :baz, Baz
        c.register :qux, Qux
      end

      baz = Injectr.resolve(:baz)
      baz.bar.foo.should be_a_kind_of(Foo)
      baz.qux.should be_a_kind_of(Qux)
    end
  end

  context "given a registered class" do
    it "instantiates an instance" do
      Injectr.create_container do |c|
        c.register :foo, Foo
      end

      Injectr.create(Foo).should be_a_kind_of(Foo)
    end
  end
end