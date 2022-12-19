class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler

    #called before every action on controllers
    before_action :authorize_request
    skip_before_action :authorize_request, only: :version
    attr_reader :current_user

    def version
        render json: {version: VERSION.join(".")}
    end

    private

    #check for valid request token and return user
    def authorize_request
        @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end
end
