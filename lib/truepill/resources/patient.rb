module Truepill
  module Resources
    class Patient < RestfulResource
      public :list, :read, :replace
    end
  end
end
