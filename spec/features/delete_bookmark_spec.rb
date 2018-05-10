feature 'delete bookmark' do
  scenario 'deleting a bookmark removes it from the list' do
    add_bookmarks
    visit '/bookmarks'
    click_on('Delete bookmark')
    fill_in 'url_field', with: 'http://google.com'
    click_button 'Submit'
    expect(page).not_to have_content('Google')
    expect(page).to have_content('Makers')
  end

  scenario 'does not delete a bookmark if it is not on the list' do
    add_bookmarks
    visit '/bookmarks'
    click_on('Delete bookmark')
    fill_in 'url_field', with: 'http://bbc.co.uk'
    click_button 'Submit'
    expect(page).to have_content('bookmark does no exist')
  end

end
