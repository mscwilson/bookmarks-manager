require 'sinatra'
require_relative "lib/bookmark"

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get "/bookmarks" do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post "/add_bookmark" do
    Bookmark.create(params["url"], params["title"])
    redirect "/bookmarks"
  end

  post '/delete_bookmarks' do
    Bookmark.delete(params.key("Delete"))
    redirect "/bookmarks"
  end

  delete "/bookmarks/:id" do
    Bookmark.delete(params[:id])
    redirect "/bookmarks"
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(params[:id])
    erb :"bookmarks/edit"
  end

  patch "/bookmarks/:id" do
    Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect "/bookmarks"
  end


  run! if app_file == $0
end
