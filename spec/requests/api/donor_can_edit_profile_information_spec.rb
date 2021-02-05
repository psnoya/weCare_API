RSpec.describe 'Api::UserController', type: :request do
  describe 'User can edit their profile page information ' do
    describe 'Successfully' do
      let(:user) { create(:user) }
      let(:user_credentials) { user.create_new_auth_token }
      let(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

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
              company_name: 'Netto55',
              adress: 'Bananvägen 258',
              zipcode: 45678,
              city: 'Kiruna',
              image: image
            }, headers: user_headers
      end

      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'is expected to return updated company name' do
        expect(response_json['user']['company_name']).to eq 'Netto55'
      end
      it 'is expected to return updated adress' do
        expect(response_json['user']['adress']).to eq 'Bananvägen 258'
      end
      it 'is expected to return updated zipcode' do
        expect(response_json['user']['zipcode']).to eq 45678
      end
      it 'is expected to return updated city' do
        expect(response_json['user']['city']).to eq 'Kiruna'
      end

      it 'user has image attached to it' do
        user = User.where(company_name: response.request.params['company_name'])
        expect(user.first.image.attached?).to eq true
      end

      describe 'Unsuccessfully' do
        describe 'Cannot update profile with wrong information' do
          before do
            put "/api/user/#{user.id}",
                params: {
                  company_name: '',
                  adress: '',
                  zipcode: '',
                  city: ''
                }, headers: user_headers
          end

          it 'is expected to respond 400' do
            expect(response).to have_http_status 400
          end
          it 'is expected to not be empty' do
            expect(response_json['company_name']).to_not eq ''
          end
          it 'is expected to not be empty' do
            expect(response_json['adress']).to_not eq ''
          end
          it 'is expected to not be empty' do
            expect(response_json['zipcode']).to_not eq ''
          end
          it 'is expected to not be empty' do
            expect(response_json['city']).to_not eq ''
          end
        end
      end
    end
  end
end
