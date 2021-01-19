require 'rails_helper'

RSpec.describe 'ユーザー登録、セッション機能のテスト', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
  end

  describe 'ユーザー登録のテスト' do
    context 'ユーザーの新規登録した場合' do
      it '新規登録したユーザーのマイページが表示される' do
        visit new_user_path
        fill_in 'user_name', with:'sample'
        fill_in 'user_email', with:'sample@example.com'
        fill_in 'user_password', with:'123456'
        fill_in 'user_password_confirmation', with:'123456'
        click_on '新規作成'
        expect(page).to have_content 'sample'
        expect(page).not_to have_content 'test1'
        expect(page).to have_content 'sample@example.com'
      end
    end

    context 'ユーザーがログインせずにタスク一覧画面に飛んだ時' do
      it 'ログイン画面に遷移される' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq tasks_path
        expect(page).to have_content 'ログインが必要です。'
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      visit new_session_path
      fill_in 'session_email', with:'test1@example.com'
      fill_in 'session_password', with:'123456'
      click_on 'ログイン'
    end

    context 'ログインした場合' do
      it 'ログインしたユーザーのマイページが表示される' do
        expect(current_path).to eq user_path(@user.id)
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test1@example.com'
        expect(current_path).not_to eq user_path(@second_user.id)
        expect(page).not_to have_content 'test2'
        expect(page).not_to have_content 'test2@example.com'
      end
    end

    context 'プロフィールをクリックした場合' do
      it '自分のマイページが表示される' do
        visit tasks_path
        click_on 'プロフィール'
        expect(current_path).to eq user_path(@user.id)
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test1@example.com'
        expect(current_path).not_to eq user_path(@second_user.id)
        expect(page).not_to have_content 'test2'
        expect(page).not_to have_content 'test2@example.com'
      end
    end

    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        visit user_path(@second_user.id)
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'タスク名'
        # expect(page).to have_content 'タスク一覧'
        expect(current_path).not_to eq user_path(@second_user.id)
      end
    end

    context 'ログアウトした場合' do
      it 'ログイン画面に戻る' do
        click_on 'ログアウト'
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq user_path(@user.id)
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
