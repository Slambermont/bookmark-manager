require 'pg'

class Link

  attr_reader :url, :title

  def initialize(url, title)
    @url = url
    @title = title
  end

  def self.all
    result = rack_up.exec("SELECT * FROM bookmarks;")
    result.map { |row| Link.new(row['url'], row['title']) }
  end

  def self.add(link, title)
    return false unless is_url?(link)
    rack_up.exec("INSERT INTO bookmarks(url, title) VALUES('#{link}', '#{title}')")
  end

  def self.delete(url)
    rack_up.exec("DELETE FROM bookmarks WHERE url = '#{url}'")
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def self.rack_up
    if ENV['RACK_ENV'] == 'test'
      PG.connect :dbname => 'bookmark_manager_test'
    else
      PG.connect :dbname => 'bookmark_manager'
    end
  end

end
