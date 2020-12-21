require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_name", with: 'タスク名'
        fill_in "task_content", with: 'タスク詳細'
        click_on "登録"
      end
    end
  end
end