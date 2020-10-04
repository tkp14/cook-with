# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'トップページ' do
    it '正常なレスポンスを返すこと' do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'クック-ウィズとは？ページ' do
    it '正常なレスポンスを返すこと' do
      get about_path
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe '利用規約ページ' do
    it '正常なレスポンスを返すこと' do
      get use_of_terms_path
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
