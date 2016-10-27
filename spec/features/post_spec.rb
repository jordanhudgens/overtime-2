require 'rails_helper'

describe 'navigate' do
  before do
      @user = FactoryGirl.create(:user) 
      login_as(@user, :scope => :user)  
  end
  context 'index' do
  	before do
       post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:second_post)  
  		visit posts_path
  	end

  	it "can be reached succesfully" do
  		  
  		expect(page.status_code).to eq(200)  
  	end 

  	it "has a title post" do 
  		  
  		expect(page).to have_content(/Post/)    
  	end 

    it "has a list of posts" do
     
        
      expect(page).to have_content(/Some rationale|Some other rationale/)    
    end   
  end
 
  context "create new post" do
  	before do
      
      visit new_post_path
  	end
  	it "can be reached" do
  		 
  		expect(page.status_code).to eq(200)      
  	end    

  	it "can be created with new form" do
  		
  		fill_in 'post[date]', with: Date.today
  		fill_in 'post[rationale]', with: "rationale"
  		click_on "Save"
 
  		expect(page).to have_content("rationale")   
  	end 

    it "will have a user associated" do  
      
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User association"
      click_on "Save"
      expect(User.last.posts.last.rationale).to eq("User association")     
       
    end       
  end
end 
