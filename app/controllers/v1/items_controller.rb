module V1
    class ItemsController < ApplicationController
        before_action :set_todo
        before_action :set_todo_item, only: [:show, :update, :destroy]

        #GET
        def index
            json_response(@todo.items)
        end

        def create
            @todo.items.create!(item_params)
            json_response(@todo, :created)
        end

        def show
            json_response(@item)
        end

        def update
            @item.update(item_params)
            head :no_content
        end

        def destroy
            @item.destroy
            head :no_content
        end

        private
        def set_todo
            @todo = Todo.find(params[:todo_id])
        end

        def set_todo_item
            @item = @todo.items.find(params[:id]) if @todo
        end

        def item_params
            params.permit(:name, :done)
        end
    end
end
