require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe InspectedRoomsController do

  # This should return the minimal set of attributes required to create a valid
  # InspectedRoom. As you add validations to InspectedRoom, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InspectedRoomsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all inspected_rooms as @inspected_rooms" do
      inspected_room = InspectedRoom.create! valid_attributes
      get :index, {}, valid_session
      assigns(:inspected_rooms).should eq([inspected_room])
    end
  end

  describe "GET show" do
    it "assigns the requested inspected_room as @inspected_room" do
      inspected_room = InspectedRoom.create! valid_attributes
      get :show, {:id => inspected_room.to_param}, valid_session
      assigns(:inspected_room).should eq(inspected_room)
    end
  end

  describe "GET new" do
    it "assigns a new inspected_room as @inspected_room" do
      get :new, {}, valid_session
      assigns(:inspected_room).should be_a_new(InspectedRoom)
    end
  end

  describe "GET edit" do
    it "assigns the requested inspected_room as @inspected_room" do
      inspected_room = InspectedRoom.create! valid_attributes
      get :edit, {:id => inspected_room.to_param}, valid_session
      assigns(:inspected_room).should eq(inspected_room)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new InspectedRoom" do
        expect {
          post :create, {:inspected_room => valid_attributes}, valid_session
        }.to change(InspectedRoom, :count).by(1)
      end

      it "assigns a newly created inspected_room as @inspected_room" do
        post :create, {:inspected_room => valid_attributes}, valid_session
        assigns(:inspected_room).should be_a(InspectedRoom)
        assigns(:inspected_room).should be_persisted
      end

      it "redirects to the created inspected_room" do
        post :create, {:inspected_room => valid_attributes}, valid_session
        response.should redirect_to(InspectedRoom.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved inspected_room as @inspected_room" do
        # Trigger the behavior that occurs when invalid params are submitted
        InspectedRoom.any_instance.stub(:save).and_return(false)
        post :create, {:inspected_room => {  }}, valid_session
        assigns(:inspected_room).should be_a_new(InspectedRoom)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        InspectedRoom.any_instance.stub(:save).and_return(false)
        post :create, {:inspected_room => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested inspected_room" do
        inspected_room = InspectedRoom.create! valid_attributes
        # Assuming there are no other inspected_rooms in the database, this
        # specifies that the InspectedRoom created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        InspectedRoom.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => inspected_room.to_param, :inspected_room => { "these" => "params" }}, valid_session
      end

      it "assigns the requested inspected_room as @inspected_room" do
        inspected_room = InspectedRoom.create! valid_attributes
        put :update, {:id => inspected_room.to_param, :inspected_room => valid_attributes}, valid_session
        assigns(:inspected_room).should eq(inspected_room)
      end

      it "redirects to the inspected_room" do
        inspected_room = InspectedRoom.create! valid_attributes
        put :update, {:id => inspected_room.to_param, :inspected_room => valid_attributes}, valid_session
        response.should redirect_to(inspected_room)
      end
    end

    describe "with invalid params" do
      it "assigns the inspected_room as @inspected_room" do
        inspected_room = InspectedRoom.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        InspectedRoom.any_instance.stub(:save).and_return(false)
        put :update, {:id => inspected_room.to_param, :inspected_room => {  }}, valid_session
        assigns(:inspected_room).should eq(inspected_room)
      end

      it "re-renders the 'edit' template" do
        inspected_room = InspectedRoom.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        InspectedRoom.any_instance.stub(:save).and_return(false)
        put :update, {:id => inspected_room.to_param, :inspected_room => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested inspected_room" do
      inspected_room = InspectedRoom.create! valid_attributes
      expect {
        delete :destroy, {:id => inspected_room.to_param}, valid_session
      }.to change(InspectedRoom, :count).by(-1)
    end

    it "redirects to the inspected_rooms list" do
      inspected_room = InspectedRoom.create! valid_attributes
      delete :destroy, {:id => inspected_room.to_param}, valid_session
      response.should redirect_to(inspected_rooms_url)
    end
  end

end