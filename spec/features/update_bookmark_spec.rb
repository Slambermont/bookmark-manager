feature 'update bookmark' do
  scenario 'changes the bookmark' do
    add_bookmarks
    visit '/bookmarks'
    click_on('Update bookmark')
    fill_in 'old_url_field', with: 'http://google.com'
    fill_in 'new_url_field', with: 'http://scoobydoo.com'
    fill_in 'new_title_field', with: 'Scooby Doo'
    click_button 'Submit'
    expect(page).to have_content('Scooby Doo')
    expect(page).not_to have_content('Google')
  end
end
