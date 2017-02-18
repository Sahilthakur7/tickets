require "rails_helper"

RSpec.feature "Users can receive notifications about tickets created" do
    let(:alice) { FactoryGirl.create(:user, email: "alice@example.com") }
    let(:bob) { FactoryGirl.create(:user, email: "bob@example.com") }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) do
        FactoryGirl.create(:ticket, project: project, author: alice)
    end

    before do
        assign_role!(alice, :manager, project)
        assign_role!(bob, :manager, project)

        login_as(bob)
        visit project_ticket_path(project, ticket)
    end

    scenario "ricket authors will reciever notifications" do
        fill_in "Text", with: "Is it you yet?"
        click_button "Create Comment"

        email = find_email!(alice.email)
        expected_subject = "[ticketee] #{project.name} - #{ticket.name}"
        expect(email.subject).to eq expected_subject

        click_first_link_in_email(email)
        expect(current_path).to eq project_ticket_path(project, ticket)
    end

    scenario "comment authors are automatically subscribed to a ticket" do
        fill_in "Text", with: "Is is out yet?"
        click_button "Create Comment"
        click_link "Sign out"

        reset_mailer

        login_as(alice)
        visit project_ticket_path(project,ticket)
        fill_in "Text", with: "Not yet - sorry!"
        click_button "Create Comment"

        expect(page).to have_content "Comment has been created"
    end
end
