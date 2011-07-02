module OfficialFM
  # @private
  module Authentication
    private

    # Authentication hash
    #
    # @return [Hash]
    def authentication
      {
        :consumer_key     => @api_key,
        :consumer_secret  => @api_secret,
        :token            => @access_token,
        :token_secret     => @access_secret,
      }
    end

    # Check whether user is authenticated
    #
    # @return [Boolean]
    def authenticated?
      authentication[:token] != nil
    end
    
    private
      
    def check_auth(name)
      raise "#{name} is an advanced API method - lacking OAuth credentials." unless authenticated?
    end
  end
end
