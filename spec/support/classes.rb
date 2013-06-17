class Foo
end

class Bar
  attr_reader :foo

  def initialize(foo)
    @foo = foo
  end
end

class Baz
  attr_reader :bar
  attr_reader :qux

  def initialize(bar, qux)
    @bar = bar
    @qux = qux
  end
end

class Qux
end