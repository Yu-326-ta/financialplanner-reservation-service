require 'rails_helper'

RSpec.describe Planner, type: :model do
  let(:planner) { Planner.new(name: 'Example Client', email: 'client@example.com', discription: 'hogehogehogehoge',
                            password: "foobar", password_confirmation: "foobar") }
 
  it 'clientが有効であること' do
    expect(planner).to be_valid
  end

  it 'nameが必須であること' do
    planner.name = ''
    expect(planner).to_not be_valid
  end

  it 'emailが必須であること' do
    planner.email = ''
    expect(planner).to_not be_valid
  end
  
  it 'nameは50文字以内であること' do
    planner.name = 'a' * 51
    expect(planner).to_not be_valid
  end
   
  it 'emailは255文字以内であること' do
    planner.email = "#{'a' * 244}@example.com"
    expect(planner).to_not be_valid
  end

  it 'emailが有効な形式であること' do
    valid_addresses = %w[client@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      planner.email = valid_address
      expect(planner).to be_valid
    end
  end

  it '無効な形式のemailは失敗すること' do
    invalid_addresses = %w[client@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      planner.email = invalid_address
      expect(planner).to_not be_valid
    end
  end

  it 'emailは小文字でDB登録されていること' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    planner.email = mixed_case_email
    planner.save
    expect(planner.reload.email).to eq mixed_case_email.downcase
  end

  it 'discriptionは1000文字以内であること' do
    planner.discription = 'a' * 1001
    expect(planner).to_not be_valid
  end

  it 'passwordが必須であること' do
    planner.password = planner.password_confirmation = ' ' * 6
    expect(planner).to_not be_valid
  end
 
  it 'passwordは6文字以上であること' do
    planner.password = planner.password_confirmation = 'a' * 5
    expect(planner).to_not be_valid
  end
end
