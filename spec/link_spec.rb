require 'link'

describe Link do
  let(:all_links) { Link.all }

  describe '#all' do
    it 'should return all bookmarks' do
      add_bookmarks
      expected_bookmarks = ['Makers', 'Google', 'Destroy']
      expect(all_links).to eq expected_bookmarks
    end
  end

  describe '#add' do
    let(:bbc_link) { 'http://bbc.co.uk' }
    let(:invalid_url) { 'invalid url' }
    it 'should add a new bookmark' do
      Link.add(bbc_link, 'bbc')
      expect(all_links).to include('bbc')
    end
    it "shouldn't add bookmark if url is invalid"do
      Link.add(invalid_url, 'bbc')
      expect(all_links).not_to include(all_links)
    end

  end
end
