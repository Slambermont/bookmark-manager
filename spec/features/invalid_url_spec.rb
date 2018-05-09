feature 'Invalid url' do
  let(:invalid_url) { 'Invalid bookmark' }
  scenario 'Show an error message when url is invalid' do
    visit '/bookmarks'
    click_on 'Add bookmark'
    fill_in 'url_field', with: invalid_url
    click_button 'Submit bookmark'
    expect(page).to have_content('This is not a valid url.')
  end
end
