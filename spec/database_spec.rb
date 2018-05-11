require 'database'

describe Database do
  let(:all_links) { Database.all }

  describe '#all' do
    it 'should return all bookmarks' do
      add_bookmarks
      expect(all_links).to all(be_instance_of(Bookmark))
    end
  end

  describe '#add' do
    it 'should add a new bookmark' do
      expect{ Database.add('http://bbc.co.uk', 'bbc') }.to change{ Database.all.length }.by(1)
    end
    it "shouldn't add bookmark if url is invalid" do
      expect{ Database.add('invalid url', 'bbc') }.to change{ Database.all.length }.by(0)
    end
  end

  describe '#delete' do
    it 'should delete the specified bookmark' do
      add_bookmarks
      expect { Database.delete('http://google.com') }.to change{ Database.all.length }.by(-1)

    end
  end

  describe '#update' do
    it 'changes the bookmark' do
      Database.add('http://bbc.co.uk', 'bbc')
      Database.all
      Database.update('http://bbc.co.uk', 'http://google.com', 'Google')
      expect(Database.all[0].url).to eq 'http://google.com'
      expect(Database.all[0].title).to eq 'Google'
    end
  end
end
