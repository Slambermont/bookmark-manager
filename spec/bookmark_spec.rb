require 'bookmark'

describe Bookmark do
  subject(:bookmark) { Bookmark.new('http://bookmark.com', 'Bookmark') }
  describe '#initialize' do
    it 'should respond to url with the url argument' do
      expect(bookmark.url).to eq('http://bookmark.com')
    end
    it 'should respond to title with the title argument' do
      expect(bookmark.title).to eq('Bookmark')
    end
  end
end
