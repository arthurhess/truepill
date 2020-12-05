module Truepill
  module Resources
    class Patient < RestfulResource
      public :list, :read

      def create(data)
        put(resource_base, data)
      end
    end
  end
end
