class Bookmark
  attr_reader :url, :title

  def initialize(url, title)
    @url = url
    @title = title
  end
end
