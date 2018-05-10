feature 'viewing bookmark' do
  scenario 'bookmarks page displays bookmakrs' do
    add_bookmarks

    visit '/bookmarks'

    expect(page).to have_content('Google')
    expect(page).to have_content('Makers')
    expect(page).to have_content('Destroy')
  end
end
