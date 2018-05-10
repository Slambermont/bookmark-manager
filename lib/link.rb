require 'pg'

class Link
  if ENV['RACK_ENV'] == 'test'
    database = 'bookmark_manager_test'
  else
    database = 'bookmark_manager'
  end

  @connection = PG.connect( dbname: database)

  def self.all
    result = @connection.exec("SELECT * FROM bookmarks;")
    result.map { |row| {title: row['title'], url: row['url']} }
  end

  def self.add(link, title)
    return false unless is_url?(link)
    @connection.exec("INSERT INTO bookmarks(url, title) VALUES('#{link}', '#{title}')")
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
