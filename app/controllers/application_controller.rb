class ApplicationController < Sinatra::Base

    set :default_content_type, "application/json"
    
    get '/' do
        {hello: "Just doing the coding 😃"}.to_json
    end

    # get all categories
    get '/categories' do
        Category.all.to_json
    end

    # get one category
    get '/categories/:id' do
        Category.find(params[:id]).to_json
    end

    # crud for todo_lists ==================================


    # create
    post '/todo_lists' do
        todo_list = TodoList.create(
            title: params[:title],
            description: params[:description],
            category_id: params[:category_id],
            status: false
        )
        todo_list.to_json
    end

    # read
    get '/todo_lists' do
        TodoList.all.to_json
    end

    # get one todo_list
    get '/todo_lists/:id' do
        TodoList.find(params[:id]).to_json
    end

    # update
    patch '/todo_lists/:id' do
        todo_list = TodoList.find(params[:id])
        todo_list.update(
            title: params[:title],
            description: params[:description],
            category_id: params[:category_id],
            status: params[:status]
        )
        todo_list.to_json
    end

    # delete
    delete '/todo_lists/:id' do
        todo_list = TodoList.find(params[:id])
        todo_list.destroy
        todo_list.to_json
    end

end