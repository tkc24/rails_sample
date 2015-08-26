require 'spec_helper'

describe Admin::Authenticator do
  describe "#admin_authenticate" do
    example '[管理者]正しいパスワードならtrueを返す' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example '[管理者]誤ったパスワードならfalseを返す' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example '[管理者]パスワード未設定ならfalseを返す' do
      m = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example '[管理者]停止フラグが立っている場合はtrueを返す' do
      m = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end
  end
end
