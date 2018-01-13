require 'rails_helper'

RSpec.describe RealEstatesController, type: :controller do

  let(:valid_attributes) {
    attributes_for :real_estate
  }

  let(:invalid_attributes) {
    attributes_for :real_estate, :invalid
  }

  describe "GET #index" do
    before(:each) do
      create_list(:real_estate, 8, type: :residential)
      create_list(:real_estate, 3, type: :unknown)
      @condo_real_estates = create_list(:real_estate, 4, type: :condo)
    end

    it "returns a success response" do
      get :index

      expect(response).to be_success
    end

    it "returns real estates total count" do
      get :index
      response_body = JSON.parse(response.body)

      expect(response_body).to have_key 'total_count'
      expect(response_body['total_count']).to eq RealEstate.count
    end

    it "returns paginated real estates" do
      get :index
      response_body = JSON.parse(response.body)

      expect(response_body).to have_key 'results'
      expect(response_body['results'].count).to eq 10
    end

    context "when query params passed" do
      it "returns real estates filtered" do
        get :index, params: { type: :condo }
        response_body = JSON.parse(response.body)

        expect(response_body['total_count']).to eq @condo_real_estates.count
      end
    end
  end

  describe "GET #show" do
    context "when real estate exists" do
      it "returns a success response" do
        real_estate = RealEstate.create! valid_attributes
        get :show, params: {id: real_estate.to_param}

        expect(response).to be_success
      end

      it "assigns the request real estate to @real_estate" do
        real_estate = RealEstate.create! valid_attributes
        get :show, params: {id: real_estate.to_param}

        expect(JSON.parse(response.body)).to include({'id'=> real_estate.id})
      end
    end

    context "when real estate does not exist" do
      it "returns a not found response" do
        get :show, params: {id: 1}

        expect(response.status).to eq 404
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new RealEstate" do
        expect {
          post :create, params: {real_estate: valid_attributes}
        }.to change(RealEstate, :count).by(1)
      end

      it "renders a JSON response with the new real_estate" do
        post :create, params: {real_estate: valid_attributes}

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(real_estate_url(RealEstate.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new real_estate" do
        post :create, params: {real_estate: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { beds: 10 }
      }

      it "updates the requested real_estate" do
        real_estate = RealEstate.create! valid_attributes
        put :update, params: {id: real_estate.to_param, real_estate: new_attributes}
        real_estate.reload
        expect(real_estate.beds).to eq 10
      end

      it "renders a JSON response with the real_estate" do
        real_estate = RealEstate.create! valid_attributes

        put :update, params: {id: real_estate.to_param, real_estate: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the real_estate" do
        real_estate = RealEstate.create! valid_attributes

        put :update, params: {id: real_estate.to_param, real_estate: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested real_estate" do
      real_estate = RealEstate.create! valid_attributes
      expect {
        delete :destroy, params: {id: real_estate.to_param}
      }.to change(RealEstate, :count).by(-1)
    end
  end

end
