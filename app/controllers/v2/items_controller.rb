class V2::ItemsController < ApplicationController
    def index
        json_response({message: 'This is items in version 2.'})
    end
end
