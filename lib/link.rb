require 'pg'

class Link
  if ENV['RACK_ENV'] == 'test'
    database = 'bookmark_manager_test'
  else
    database = 'bookmark_manager'
  end

  @connection = PG.connect( dbname: database)

  def self.all
    list = []
    @connection.exec("SELECT * FROM bookmarks;").each { |link| list << link['url'] }
    list
  end

  def self.add(link)
    return false unless is_url?(link)
    @connection.exec("INSERT INTO bookmarks VALUES(DEFAULT, '#{link}')")
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
end
