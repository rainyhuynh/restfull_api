module ControllerSpecHelper
    #generate tokens form user id

    def token_generator(user_id)
        JsonWebToken.encode(user_id: user_id)
    end

    def expired_token_generator(user_id)
        JsonWebToken.encode( { user_id: user_id}, (Time.now.to_i - 10))
    end

    #return valid headers
    def valid_header
        {
            "Authorization" => toke_generator(user.id),
            "Content-Type" => "application/json"
        }
    end

    def invalid_headers
        {
            "Authorization" => nil,
            "Content-Type" => "application/json"
        }
    end
end