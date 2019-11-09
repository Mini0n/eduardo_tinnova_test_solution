require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

  describe '#login' do
    context 'valid login' do
      let(:valid_login) { { user: { username: 'admin', password: 'admin' } } }
      let(:invalid_login) { { user: { username: 'bad', password: 'login' } } }

      it 'logins' do
        post 'login', params: valid_login
        result = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(result['username']).to eq valid_login[:user][:username]
        expect(result['token'].present?).to be true
      end

      it 'fails' do
        post 'login', params: invalid_login

        expect(response.status).to eq 200
        expect(response.body).to eq 'null'
      end
    end
  end
end
