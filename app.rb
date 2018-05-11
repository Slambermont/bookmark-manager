require 'sinatra/base'
require './lib/database.rb'
require 'uri'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  before do
    @bookmarks = Database.all
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
    Database.add(url, title) ? redirect('/bookmarks') : (flash[:error] = 'This is not a valid url.'; redirect('/add_bookmark'))
  end

  get '/delete_bookmark' do
    erb :delete_bookmark
  end

  post '/delete_bookmark' do
    url = params[:url_field]
    Database.delete(url).cmd_tuples == 0 ? (flash[:no_url] = 'bookmark does no exist' ; redirect('/delete_bookmark')) : redirect('/bookmarks')
  end

  get '/update_bookmark' do
    erb :update_bookmark
  end

  post '/update_bookmark' do
    old_url = params['old_url_field']
    new_url = params['new_url_field']
    new_title = params['new_title_field']
    Database.update(old_url, new_url, new_title) ? redirect('/bookmarks') : (flash[:new_error] = 'Entries invalid' ; redirect('update_bookmark'))

  end

  run! if app_file == $0
end
