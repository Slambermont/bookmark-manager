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
      expect{ Link.add('http://bbc.co.uk', 'bbc') }.to change{ Link.all.length }.by(1)
    end
    it "shouldn't add bookmark if url is invalid" do
      expect{ Link.add('invalid url', 'bbc') }.to change{ Link.all.length }.by(0)
    end
  end

  describe '#delete' do
    it 'should delete the specified bookmark' do
      add_bookmarks
      expect {Link.delete('http://google.com')}.to change{Link.all.length}.by(-1)

    end
  end
end
