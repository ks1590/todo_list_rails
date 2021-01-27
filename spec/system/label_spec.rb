require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user)
    @second_task = FactoryBot.create(:second_task, user: @user)
    @label = FactoryBot.create(:label)
    @second_label = FactoryBot.create(:second_label)
    @third_label = FactoryBot.create(:third_label)
    FactoryBot.create(:task_label, task:@task, label:@label)
    FactoryBot.create(:task_label, task:@task, label:@second_label)
    FactoryBot.create(:task_label, task:@second_task, label:@third_label)
    visit new_session_path
    fill_in 'session_email', with:'test1@example.com'
    fill_in 'session_password', with:'123456'
    click_on 'commit'
    visit tasks_path
  end

  context '複数のラベルを付けてタスクの新規作成した場合' do
    it 'タスクに選択したラベルが表示される' do
      visit new_task_path
      fill_in "task_name", with: 'ラベルテスト'
      fill_in "task_content", with: 'ラベル機能のテスト'
      fill_in "task_deadline", with: '002021-12-30'
      select "中", from: 'task_priority'
      select "着手中", from: "task_status"
      check "task_label_ids_#{(@label.id)}"
      check "task_label_ids_#{(@second_label.id)}"
      click_on "登録"
      expect(all('tbody tr')[0]).to have_content 'HTML'
      expect(all('tbody tr')[0]).to have_content 'JavaScript'
      expect(all('tbody tr')[0]).to have_content 'ラベルテスト'
      expect(all('tbody tr')[0]).not_to have_content 'Ruby'
      expect(page).to have_content '新しいToDoリストを登録しました！'
    end
  end

  context 'タスクのラベルを外して編集した場合' do
    it 'タスク一覧のタスクから外したラベルが消えている' do
      visit edit_task_path(@task.id)
      select "中", from: 'task_priority'
      select "着手中", from: "task_status"
      uncheck "task_label_ids_#{(@label.id)}"
      click_on "登録"
      expect(all('tbody tr')[0]).not_to have_content 'HTML'
      expect(all('tbody tr')[0]).to have_content 'Ruby'
      expect(all('tbody tr')[0]).not_to have_content 'JavaScript'
    end
  end

  context 'ラベル検索をした場合' do
    it "検索したラベルが含まれるタスクが絞り込まれる" do
      visit tasks_path
      select "Ruby", from: "search[label_id]"
      click_on "検索"
      expect(page).not_to (have_selector 'td', text: 'HTML')
      expect(page).not_to (have_selector 'td', text: 'JavaScript')
      expect(page).to (have_selector 'td', text: 'Ruby')
    end
  end
end