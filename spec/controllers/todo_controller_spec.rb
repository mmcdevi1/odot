require 'spec_helper'

describe TodoListsController do 
  let(:valid_session) { {} }
  let!(:user) { create(:user) }

  before do 
    sign_in(user)
  end

  describe "GET index" do 
    it "sets the @todos variable" do 
      cook  = user.todo_lists.create(title: "cook", description: "description")
      sleep = user.todo_lists.create(title: "sleep", description: "description")

      get :index, {}, valid_session
      assigns(:todo_lists).should == [cook, sleep]
    end

    it "renders the index template" do 
      get :index, {}, valid_session
      response.should render_template :index
    end
  end

  describe "GET new" do   
    it "sets the @todo variable" do 
      get :new, {}, valid_session
      assigns(:todo_list).should be_new_record
      assigns(:todo_list).should be_instance_of(TodoList)
    end

    it "renders the new template" do 
      get :new, {}, valid_session
      response.should render_template :new
    end
  end

  describe "POST create" do 
    it "creates the todo record when the input is valid" do 
      post :create, todo_list: { title: "title", description: "description" }
      TodoList.first.title.should       == "title"
      TodoList.first.description.should == "description"
    end

    it "redirects to the root path when the input is valid" do 
      post :create, todo_list: { title: "title", description: "description" }
      response.should redirect_to(TodoList.last)
    end

    it "renders the new template when the input is invalid" do 
      post :create, todo_list: { title: "", description: "" }
      TodoList.count.should eq(0)
      response.should render_template :new
    end
  end
end