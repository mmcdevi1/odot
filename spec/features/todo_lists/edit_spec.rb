require 'spec_helper'

describe "Editing todo lists" do 
  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list.") }

  def update_todo_list(options={})
    options[:title] ||= "New title"
    options[:description] ||= "New description"

    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do 
      click_link "Edit"
    end    

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  it "updates a todo list successfully with correct information" do     
    update_todo_list todo_list: todo_list, title: "New title", description: "New description"

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated")
    expect(todo_list.title).to eq("New title")
    expect(todo_list.description).to eq("New description")
  end

  it "displays an error when the todo list has no title" do 
    update_todo_list todo_list: todo_list, title: ""
    expect(page).to have_content("error")
  end

  it "displays an error when the todo list title is too short" do 
    update_todo_list todo_list: todo_list, title: "hi"
    expect(page).to have_content("error")
  end

  it "displays an error when the todo list has no description" do 
    update_todo_list todo_list: todo_list, description: ""
    expect(page).to have_content("error")
  end

  it "displays an error when the todo list description is too short" do 
    update_todo_list todo_list: todo_list, description: "hi"
    expect(page).to have_content("error")
  end
end