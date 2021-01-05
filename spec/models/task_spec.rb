require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', content: 'タイトル失敗テスト')
        expect(task).not_to be_valid
      end
    end

    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '詳細失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = FactoryBot.create(:task, name: '成功テスト', content: '成功テスト')
        expect(task).to be_valid
      end
    end
  end

    describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, name: 'test1', status: "未着手") }
    let!(:second_task) { FactoryBot.create(:second_task, name: "test2", status: "着手中") }
    let!(:third_task) { FactoryBot.create(:second_task, name: "test3", status: "完了") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.name_like('es')).to include(task,second_task,third_task)
        expect(Task.name_like('et')).not_to include(task,second_task,third_task)        
        expect(Task.name_like('es').count).to eq 3
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status('未着手')).to include(task)
        expect(Task.status('未')).not_to include(task)
        expect(Task.status('未着手')).not_to include(second_task,third_task)
        expect(Task.status('着手中')).to include(second_task)
        expect(Task.status('着手')).not_to include(second_task)
        expect(Task.status('着手中')).not_to include(task,third_task)
        expect(Task.status('完了')).to include(third_task)
        expect(Task.status('完')).not_to include(third_task)
        expect(Task.status('完了')).not_to include(task,second_task)
        expect(Task.status('未着手').count).to eq 1
        expect(Task.status('着手中').count).to eq 1
        expect(Task.status('完了').count).to eq 1
        expect(Task.status('着手').count).to eq 0
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.name_like('es').status('未着手')).to include(task)
        expect(Task.name_like('es').status('未着手')).not_to include(second_task,third_task)
        expect(Task.name_like('es').status('着手中')).to include(second_task)
        expect(Task.name_like('es').status('着手中')).not_to include(task,third_task)
        expect(Task.name_like('es').status('完了')).to include(third_task)
        expect(Task.name_like('es').status('完了')).not_to include(task,second_task)
        expect(Task.name_like('es').status('未着手').count).to eq 1
        expect(Task.name_like('es').status('着手中').count).to eq 1
      end
    end
  end
end
