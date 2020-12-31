require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_name", with: 'テスト1'
        fill_in "task_content", with: 'タスク詳細'
        fill_in "task_deadline", with: '002020-12-30'
        select "中", from: 'task_priority'
        select "完了", from: 'task_status'
        click_on "登録"
        expect(page).to have_content "テスト1"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'テスト1'
        expect(page).to have_content 'テスト2'
        expect(page).to have_content 'テスト3'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        expect(all('tbody tr')[0]).to have_content 'テスト3'
      end
    end
  end
end