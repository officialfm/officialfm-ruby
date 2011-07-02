module OfficialFM
  # @private
  module Authentication
    private

    # Authentication hash
    #
    # @return [Hash]
    def authentication
      puts "token: #{@access_token}, token_secret: #{@access_secret}"
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
  end
end
