Injectr
=======

Super simple IOC for Rails

How to install
--------------

Add this to your gem file and run ```$ bundle```:

```
gem 'injectr', github: 'andypike/injectr'
```

How to use
----------

Add a new file into your initilizers folder called 'injectr.rb' and specify your components:

```
Injectr.create_container do |c|
  c.register :craftsman, Carpenter
  c.register :tool, PowerSaw  
  c.register :fixings, Nails  
  c.register :power_source, Electricity
end
```

If you want to create an instance of one of there classes then just resolve the root:

```
craftsman = Injectr.resolve(:craftsman)
```

Injecting into a Rails controller:
----------------------------------

Just add an constructor with args names that match the registered keys. DON'T FORGET TO CALL SUPER()

```
class HomeController < ApplicationController
  def initialize(craftsman)
    super()

    @craftsman = craftsman
  end

  def index
    render :text => @craftsman.build_something
  end
end
```

What do you need to add to your classes?
----------------------------------------

Nothing. Just Plain Old Ruby Objects work fine. You only need to match the constructor arg names with the registered keys. Here's an example set that work with the above examples:

```
class Nails
  def to_s
    "nails"
  end
end
 
class Glue
  def to_s
    "glue"
  end
end
 
class PowerSaw
  def initialize(power_source)
    @power_source = power_source
  end
 
  def to_s
    "#{@power_source} power saw"
  end
end
 
class HandSaw
  def to_s
    "hand saw"
  end
end
 
class Electricity
  def to_s
    "electrical"
  end
end
 
class Carpenter
  def initialize(tool, fixings)
    @tool = tool
    @fixings = fixings
  end
 
  def build_something
    "Building something in wood with #{@fixings} and #{@tool}"
  end
end
```