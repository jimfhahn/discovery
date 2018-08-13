require_relative "../rails_helper"

describe SymphonyController, type: :controller do

  it "should have a collection name" do
    get :index
    expect(response).to have_http_status(:success)
    expect(assigns(:collection_name)).to eq "Books, media, & more"
  end

end
