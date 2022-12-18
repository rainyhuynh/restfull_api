class AuthorizeApiRequest
    def initialize(headers = {})
        @headers = headers
    end

    #Service entry point - return valid user object
    def call
        {
            user: user
        }
    end

    private
    attr_reader :headers

    def user
        #check if user is in the database
        #memoize user object
        @user ||= User.find(decode_auth_token[:user_id]) if decode_auth_token 
        #handle user not found
    rescue ActiveRecord::RecordNotFound => e
        #raise custom error
        raise(
            ExceptionHandler::InvalidToken,
            ("#{Message.invalid_token} #{e.message}")
        )
    end

    #decode authencication token
    def decode_auth_token
        @decode_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
        if headers['Authorization'].present?
            return headers['Authorization'].split(' ').last
        end
        raise(ExceptionHandler::MissingToken, Message.missing_token)
    end
end