class ApplicationController < Sinatra::Base

    set :default_content_type, "application/json"

    # allow access-control-allow-origin header on all requests
    before do
        response.headers["Access-Control-Allow-Origin"] = "*"
    end
    
    get '/' do
        {hello: "Just doing the coding 😃"}.to_json
    end

    # get all categories
    get '/categories' do
        Category.all.to_json
    end

    # get one category
    get '/category/:id' do
        Category.find(params[:id]).to_json
    end


    # crud for todo_lists ==================================


    # create
    post '/todo_list' do
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
        TodoList.all.to_json(include: :category)
    end

    # get one todo_list
    get '/todo_list/:id' do
        TodoList.find(params[:id]).to_json(include: :category)
    end

    # update
    patch '/todo_list/:id' do
        todo_list = TodoList.find(params[:id])
        todo_list.update(
            title: params[:title],
            description: params[:description],
            category_id: params[:category_id],
            status: params[:status]
        )
        {message: "Todo list updated!"}.to_json
    end

    # delete
    delete '/todo_list/:id' do
        todo_list = TodoList.find(params[:id])
        todo_list.destroy
        {message: "Todo List '#{todo_list.title}' has been deleted."}.to_json
    end



    # abit of advanced stuffs huhh 😎 ===============================


    # get all todo_lists of a category
    get '/category/:id/todo_lists' do
        Category.find(params[:id]).todo_lists.to_json(include: :category)
    end

    # get all todo_lists of a category that are not completed
    get '/category/:id/todo_lists/active' do
        Category.find(params[:id]).todo_lists.where(status: false).to_json(include: :category)
    end

    # get all todo_lists of a category that are completed
    get '/category/:id/todo_lists/completed' do
        Category.find(params[:id]).todo_lists.where(status: true).to_json(include: :category)
    end

end