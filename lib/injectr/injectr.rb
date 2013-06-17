class Injectr
  attr_reader :registry
 
  def self.create_container
    @container = self.new
    yield @container
    @container
  end
 
  def self.resolve(key)
    klass = @container.registry[key]
    create(klass)
  end
 
  def self.create(klass)
    constructor_params = klass.instance_method(:initialize).parameters
    dependancies = constructor_params.map{|p| resolve(p.last)}
    klass.new(*dependancies)
  end

  def initialize
    @registry = {}
  end
 
  def register(key, klass)
    @registry[key] = klass
  end
end