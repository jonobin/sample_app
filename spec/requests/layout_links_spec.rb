require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  
  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end
  
  it "should have a About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end
  
  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
  
  it "should have a Help page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end
  
  it "should have the right links on the layout" do
    
    #visits the root path page
    visit root_path
    
    #on the root page, simulate a click to the About link, which should visit the destination page
    click_link "About"
    response.should have_selector('title', :content => "About")
    
    #on the root page, simulate a click to the About link, which should visit the destination page
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    
    #on the root page, simulate a click to the About link, which should visit the destination page
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    
    #on the root page, simulate a click to the About link, which should visit the destination page
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    
    #on the root page, simulate a click to the About link, which should visit the destination page
    click_link "Sign up now!"
    response.should have_selector('title', :content => "Sign up")
  end
end
