module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user#, :current_client

    def connect
      self.current_user = find_verified_user
      #self.current_client = find_client
    end

    private

    def find_verified_user
      if verified_user = env['warden'].user
        Client.new(id: cookies.encrypted[:client_id])
        verified_user
      else
        reject_unauthorized_connection
      end

    end

    # def find_client
    #   Client.new(id: cookies.encrypted[:client_id])
    # end
  end
end
