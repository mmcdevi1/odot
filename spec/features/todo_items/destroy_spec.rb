require 'spec_helper'

describe "Deleting todo items" do 
  let!(:todo_list) { TodoList.create(title: "Grocery List", description: "Groceries to buy") }
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

  it "is successful when deleting a list item" do 
    visit_todo_list(todo_list)
    within "#todo_item_#{todo_item.id}" do 
      click_link "Delete"
    end
    expect(page).to_not have_content("Milk")
    expect(page).to have_content("Todo list item was deleted.")
    expect(TodoItem.count).to eq(0)
  end
end 