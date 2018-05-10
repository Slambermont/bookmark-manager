feature 'clicking bookmark' do
  scenario 'takes you to the url' do
    add_bookmarks
    visit '/bookmarks'
    save_and_open_page
    click_link 'Google'
    expect(page).to have_content('United Kingdom')
  end
end
