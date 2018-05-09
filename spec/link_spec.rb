require 'link'

describe Link do
  let(:all_links) { Link.all }

  describe '#all' do
    it 'should return all bookmarks' do
      add_bookmarks

      expect(all_links).to include('http://makersacademy.com')
      expect(all_links).to include('http://google.com')
      expect(all_links).to include('http://destroyallsoftware.com')
    end
  end

  describe '#add' do
    let(:bbc_link) { 'http://bbc.co.uk' }
    let(:invalid_url) { 'invalid url' }
    it 'should add a new bookmark' do
      Link.add(bbc_link)
      expect(all_links).to include(bbc_link)
    end
    it "shouldn't add bookmark if url is invalid"do
      Link.add(invalid_url)
      expect(all_links).not_to include(all_links)
    end

  end
end
