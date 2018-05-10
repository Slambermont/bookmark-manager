feature 'Adding a bookmark' do
  let(:bbc_link) { 'http://bbc.co.uk' }

  scenario 'Add bookmark link visible' do
    visit '/bookmarks'

    expect(page).to have_content("Add bookmark")
  end

  scenario 'Go to add_bookmark page' do
    visit '/bookmarks'
    click_on 'Add bookmark'
    expect(page).to have_content('Add url')
    expect(page).to have_content('Add bookmark name')
  end

  scenario 'Adds bookmark to database' do
    visit '/bookmarks'
    click_on 'Add bookmark'
    fill_in 'url_field', with: bbc_link
    fill_in 'title_field', with: 'bbc'
    click_button 'Submit bookmark'
    expect(page).not_to have_content(bbc_link)
    expect(page).to have_content('bbc')
  end
end
