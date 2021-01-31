RSpec.describe 'Api::ProfileController', type: :request do
  describe 'Donor can upload image to their profile' do
    describe 'Successfully' do
      let(:user_headers) {{HTTP_ACCEPT: 'application/json'}.merge!(user_credentials)}

      let(:image) do
        {
          type: 'application/png',
          encoder: 'name=donor_logo.png:base64',
          data: 'DJHBDLKJFBSDJBSKJDABLKAJDBVLKJADBVLADJBVLJAH',
          extension: 'png'
        }
      end
      before do
        put "/api/user/#{user.id}",
            params: {
              image: image
            }, headers: user_headers
      end

      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end





    end
  end



end