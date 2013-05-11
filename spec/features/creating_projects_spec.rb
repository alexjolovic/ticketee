require 'spec_helper'

feature 'Creating Projects' do

  before do
    visit root_path
    click_link 'New Project'
  end
  
  scenario "can create a project" do
     
    fill_in 'Name', :with => 'TextMate 2'
    fill_in 'Description', :with => 'A text-editor for OS X'
    
    click_button 'Create Project'
    
    expect(page).to have_content('Project has been created.')

    project = Project.where(name: "TextMate 2").first

    #ensures that you're on what should be the show action inside the ProjectsController
    
    expect(page.current_url).to eql(project_url(project))
    
    title = "TextMate 2 - Projects - Ticketee"

    #finds the title element on the page by using Capybara's find method and checks using have_content
    
    expect(find("title").native.text).to have_content(title)

  end

  scenario "can not create a project without a name" do
    
    click_button 'Create Project'
   
    expect(page).to have_content("Project has not been created.")
   
    expect(page).to have_content("Name can't be blank")
  
  end

end
