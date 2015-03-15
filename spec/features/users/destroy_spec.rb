require "spec_helper"

describe "Logging Out" do
  it "allows a signed in user to sign out" do
    user = create(:user)
    visit "/todo_lists"
    

    expect(page).to have_content("Logout")
    click_link "Logout"
    expect(page).to_not have_content("Logout")
    expect(page).to have_content("Log In")
  end
end