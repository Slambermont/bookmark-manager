require 'pg'
require_relative 'bookmark'

class Database

  def self.all(connection = rack_up)
    result = connection.exec("SELECT * FROM bookmarks;")
    result.map { |row| Bookmark.new(row['url'], row['title']) }
  end

  def self.add(link, title, connection = rack_up)
    return false unless is_url?(link)
    connection.exec("INSERT INTO bookmarks(url, title) VALUES('#{link}', '#{title}')")
  end

  def self.delete(url, connection = rack_up)
    connection.exec("DELETE FROM bookmarks WHERE url = '#{url}'")
  end

  def self.update(old_url, new_url, new_title, connection = rack_up)
    return false unless is_in_all?(old_url) == true
    return false unless is_url?(new_url)
    connection.exec("UPDATE bookmarks SET title = '#{new_title}', url = '#{new_url}' WHERE url = '#{old_url}'")
  end

  private

  def self.is_in_all?(url)
    all.each do |instance|
      return true if instance.url == url
    end
  end

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
