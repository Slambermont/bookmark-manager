require 'link'

describe Link do
  let(:all_links) { Link.all }

  describe '#all' do
    it 'should return all bookmarks' do
      add_bookmarks
      expect(all_links).to all(be_instance_of(Link))
    end
  end

  describe '#add' do
    it 'should add a new bookmark' do
      Link.add('http://bbc.co.uk', 'bbc')
      expect(all_links).to all(be_instance_of(Link))
    end
    it "shouldn't add bookmark if url is invalid"do
      Link.add('invalid url', 'bbc')
      expect(all_links).to eq []
    end

  end
end
