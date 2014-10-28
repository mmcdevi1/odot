require 'spec_helper'

describe "Adding todo items" do 
  let!(:todo_list) { user.todo_lists.create(title: "Grocery list", description: "Groceries to buy") }
  let(:user) { create(:user) }

  before do 
    sign_in user, password: "password"
  end

  it "is successful with valid content" do 
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "Milk"
    click_button "Save"
    expect(page).to have_content("Added todo list item.")
    within("ul.todo_items") do 
      expect(page).to have_content("Milk")
    end 
  end

  it "displays an error if todo item content is empty" do 
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: ""
    click_button "Save"
    within("div.flash") do 
      expect(page).to have_content("There was a problem adding that todo list item.")
    end
    expect(page).to have_content("Content can't be blank")
  end

  it "displays an error if todo item content is less than 2 characters long" do 
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "h"
    click_button "Save"
    within("div.flash") do 
      expect(page).to have_content("There was a problem adding that todo list item.")
    end
    expect(page).to have_content("Content is too short")
  end

end