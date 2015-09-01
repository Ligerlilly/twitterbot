# require 'spec_helper'
#
# Capybara.app = Sinatra::Application
# set(:show_exceptions, false)
#
# describe 'search path', { type: :feature } do
#   it 'returns results' do
#     visit '/search'
#     fill_in 'query', with: 'under the bridge'
#     click_button 'Submit'
#     expect(page).to have_content 'Result'
#   end
# end
