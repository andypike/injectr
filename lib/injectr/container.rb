class Injectr
  attr_reader :registry
 
  def self.create_container
    @container = self.new
    yield @container
  end
 
  def self.resolve(key)
    klass = @container.registry[key]
    create(klass)
  end
 
  def self.create(klass)
    constructor_params = klass.instance_method(:initialize).parameters
    required_dependancies = constructor_params.select{|p| p.first == :req}
                                              .map{|p| resolve(p.last)}
    klass.new(*required_dependancies)
  end

  def initialize
    @registry = {}
  end
 
  def register(key, klass)
    @registry[key] = klass
  end
end