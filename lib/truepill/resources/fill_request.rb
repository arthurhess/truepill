module Truepill
  module Resources
    class FillRequest < RestfulResource
      public :create, :read

      def update(id, data)
        post('update_request', data.merge(request_id: id))
      end

      def cancel(id)
        post('cancel_request', { request_id: id })
      end

      def update_payment(id, data)
        post('update_fill_request_payment', data.merge(request_id: id))
      end
    end
  end
end
