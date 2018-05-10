feature 'clicking bookmark' do
  scenario 'takes you to the url' do
    add_bookmarks
    visit '/bookmarks'
    click_link 'Google'
    expect(page).to have_current_path('http://google.com')
  end
end
