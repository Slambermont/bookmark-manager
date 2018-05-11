require 'database'

describe Database do
  let(:connection) { double :connection, exec: nil }
  let(:google_title) { 'Google' }
  let(:google_url) { 'http://google.com' }
  let(:bad_url) { 'THIS IS WRONG' }
  let(:bbc_url) { 'http://bbc.co.uk' }


  describe '#add' do
    it 'return SQL message with the arguments' do
      expect(connection).to receive(:exec).with("INSERT INTO bookmarks(url, title) VALUES('http://google.com', 'Google')")
      Database.add(google_url, google_title, connection)
    end

    it 'returns false if url is incorrect' do
      expect(Database.add(bad_url, google_title, connection)).to eq(false)
    end
  end

  describe '#delete' do
    it 'return SQL message with the arguments' do
      expect(connection).to receive(:exec).with("DELETE FROM bookmarks WHERE url = 'http://google.com'")
      Database.delete(google_url, connection)
    end
  end

  describe '#update' do
    it 'return SQL message with the arguments' do
      allow(Database).to receive(:is_in_all?).with("http://bbc.co.uk") {true}
      expect(connection).to receive(:exec).with("UPDATE bookmarks SET title = 'Google', url = 'http://google.com' WHERE url = 'http://bbc.co.uk'")
      Database.update(bbc_url, google_url, google_title, connection)
    end

    it 'returns false if url is incorrect' do
      allow(Database).to receive(:is_in_all?).with("http://bbc.co.uk") {false}
      expect(Database.update(bbc_url, google_url, google_title, connection)).to eq false
    end

    it "returns false if bookmark doesn't exist" do
      expect(Database.update(bad_url, google_url, google_title, connection)).to eq false
    end
  end

  
end

# describe Database do
#   let(:all_links) { Database.all }
#
#   describe '#all' do
#     it 'should return all bookmarks' do
#       add_bookmarks
#       expect(all_links).to all(be_instance_of(Bookmark))
#     end
#   end
#
#   describe '#add' do
#     it 'should add a new bookmark' do
#       expect{ Database.add('http://bbc.co.uk', 'bbc') }.to change{ Database.all.length }.by(1)
#     end
#     it "shouldn't add bookmark if url is invalid" do
#       expect{ Database.add('invalid url', 'bbc') }.to change{ Database.all.length }.by(0)
#     end
#   end
#
#   describe '#delete' do
#     it 'should delete the specified bookmark' do
#       add_bookmarks
#       expect { Database.delete('http://google.com') }.to change{ Database.all.length }.by(-1)
#
#     end
#   end
#
#   describe '#update' do
#     it 'changes the bookmark' do
#       Database.add('http://bbc.co.uk', 'bbc')
#       Database.all
#       Database.update('http://bbc.co.uk', 'http://google.com', 'Google')
#       expect(Database.all[0].url).to eq 'http://google.com'
#       expect(Database.all[0].title).to eq 'Google'
#     end
#   end
# end
