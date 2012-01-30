require 'spec_helper'

describe "Microposts" do
  
  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,     :with => @user.email
    fill_in :password,  :with => @user.password
    click_button
  end
  
  describe "creation" do
    describe "failure" do
      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Micropost, :count)
      end
    end
    
    describe "success" do
      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"

        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
        end.should change(Micropost, :count).by(1)
      end  
    end
  end
  
  describe "check micropost counts" do
    it "should have the correct count - singular" do
      visit root_path
      count = @user.microposts.count
      response.should have_selector("span.microposts", :content => "#{count} micropost")
    end
    
    it "should have the correct count - multiple" do
      content = "Lorem ipsum dolor sit amet"

      lambda do
        visit root_path
        fill_in :micropost_content, :with => content
        click_button
        
        visit root_path
        fill_in :micropost_content, :with => content
        click_button
        count = @user.microposts.count
        response.should have_selector("span.microposts", :content => "#{count} microposts")
      end.should change(Micropost, :count).by(2)
    end
  end

  describe "display all microposts" do
    before(:each) do
      content = "Goober says hey!"

      2.times do |n|
        visit root_path
        fill_in :micropost_content, :with => content + n.to_s()
        click_button
      end
    end

    it "should display microposts" do
      visit user_microposts_path(@user)
      response.should have_selector("td", :class => "micropost")
      response.should have_selector("span", :class => "content")
    end

    it "should show the proper count of microposts" do
      visit user_microposts_path(@user)

      response.should have_selector("span", :class => "num_posts", :content => @user.microposts.count.to_s())
    end
  end
end
