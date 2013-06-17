if defined?(Rails)

  module ActionController
    class Metal < AbstractController::Base
      def self.action(name, klass = ActionDispatch::Request)
        middleware_stack.build(name.to_s) do |env|
          Injectr.create(self).dispatch(name, klass.new(env))
        end
      end
    end
  end
  
end