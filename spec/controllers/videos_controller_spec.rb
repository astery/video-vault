require 'rails_helper'

RSpec.describe VideosController do
  describe 'GET #index' do
    context 'when user is not signed' do
      it 'redirect to sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'shows flash message' do
        get :index
        expect(flash[:alert]).to have_content 'You need to sign in'
      end
    end
  end
end
