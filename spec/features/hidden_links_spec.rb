require "rails_helper"

RSpec.feature "Users can only see the appropriate links" do
    let(:user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:user, :admin) }
    let(:project) { FactoryGirl.create(:project) }

    context "anonymous users" do
        scenario "cannot see new project link" do
            visit "/"
            expect(page).not_to have_link "New Project"
        end
    end

    context "non-admin users (project viewers)" do
        before do
            login_as(user)
            assign_role!(user, :viewer, project)
        end

    scenario "cannot see new project link" do
            visit "/"
            expect(page).not_to have_link "New Project"
        end     
    end

 scenario "cannot see the edit project link" do
            visit project_path(project)
            expect(page).not_to have_link "Edit Project"
        end

 scenario "cannot see the new ticket link" do
     visit project_path(project)
     expect(page).not_to have_link "New Ticket"
 end
   

    context "admin users" do
        before { login_as(admin) }

        scenario "can see the New Project link" do
            visit "/"
            expect(page).to have_link "New Project"
        end
        
        scenario "can see the edit project link" do
            visit project_path(project)
            expect(page).to have_link "Edit Project"
        end

        scenario "can see the new ticket link" do
            visit project_path(project)
            expect(page).to have_link "New Ticket"
        end
end
end
