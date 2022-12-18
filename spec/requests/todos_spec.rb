RSpec.describe 'Todos API', type: :request do
    #initialize test data
    let!(:todos) { create_list(:todo, 10)}
    let(:todo_id) { todos.first.id}

    #Test suite for GET /todos
    describe 'GET /todos' do 
        #make HTTP get request before each example
        before { get '/todos'}

        it 'returns todos' do
            #Note 'json' is a custim helper to parse JSON response
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    #Test suite for GET /todos/:id
    describe 'GET /todos/:id' do
        before { get "/todos/#{todo_id}" }

        context 'when the record exists' do
            it 'returns the todo' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(todo_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end
        
        context 'when record does not exists' do
            let(:todo_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'return a not found message' do
                expect(response.body).to match(/Couldn't find Todo/)
            end
        end
    end

    #Test suite for POST /todos
    describe 'POST /todos' do
        #valid payload
        let(:valid_attributes) { {title: 'Learn Elm', created_by: '1'}}
   
        context 'when the request is valid' do
            before { post '/todos', params: valid_attributes}
            
            it 'creates a todo' do
                expect(json['title']).to eq('Learn Elm')
            end

            it 'return status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post '/todos', params: {title: 'Foobar'} }

            it 'return status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Validation failed: Created by can't be blank/)
            end
        end
    end

    #Test suite for PUT /todos/:id
    describe 'PUT /todos/:id' do
        let(:valid_attributes) { {title: 'Shopping'}}

        context 'when the record exists' do
            before { put "/todos/#{todo_id}", params: valid_attributes}

            it 'updates the record' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    #Test suite for DELETE /todo/:id
    describe 'DELETE /todos/:id' do
        before { delete "/todos/#{todo_id}"}

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end

end