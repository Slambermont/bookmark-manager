require 'sinatra/base'
require './lib/link.rb'
require 'uri'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  before do
    @bookmarks = Link.all
  end

  get '/bookmarks' do
    erb :index
  end

  get '/add_bookmark' do
    erb :add_bookmark
  end

  post '/add_bookmark' do
    url = params[:url_field]
    title = params[:title_field]
    Link.add(url, title) ? redirect('/bookmarks') : (flash[:error] = 'This is not a valid url.'; redirect('/add_bookmark'))
  end

  get '/delete_bookmark' do
    erb :delete_bookmark
  end

  post '/delete_bookmark' do
    url = params[:url_field]
    Link.delete(url).cmd_tuples == 0 ? (flash[:no_url] = 'bookmark does no exist' ; redirect('/delete_bookmark')) : redirect('/bookmarks')
  end

  run! if app_file == $0
end
