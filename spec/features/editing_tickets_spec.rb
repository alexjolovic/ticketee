require 'spec_helper'

feature 'Eidit tickets' do
  let!(:project) {FactoryGirl.create(:project)}
  let!(:ticket) { FactoryGirl.create(:ticket, project: project)}

  before do
    visit root_path
    click_link project.name
    click_link ticket.title
    click_link 'Edit Ticket'
  end

  scenario 'Update a ticket' do
    ticket_title = 'Make it really shine!'
    fill_in 'Title', with: ticket_title
    click_button 'Update Ticket'

    expect(page).to have_content('Ticket has been updated.')

    within('#ticket h2') do
      expect(page).to have_content(ticket_title)
    end

    expect(page).to_not have_content(ticket.title)
  end

  scenario 'Update a ticket with invalid information' do
    fill_in 'Title', with: ''
    click_button 'Update Ticket'

    expect(page).to have_content("Ticket has not been updated.")
  end

end
