require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { Client.new(name: 'Example Client', email: 'client@example.com',
                            password: "foobar", password_confirmation: "foobar") }
 
  it 'clientが有効であること' do
    expect(client).to be_valid
  end

  it 'nameが必須であること' do
    client.name = ''
    expect(client).to_not be_valid
  end

  it 'emailが必須であること' do
    client.email = ''
    expect(client).to_not be_valid
  end
  
  it 'nameは50文字以内であること' do
    client.name = 'a' * 51
    expect(client).to_not be_valid
  end
   
  it 'emailは255文字以内であること' do
    client.email = "#{'a' * 244}@example.com"
    expect(client).to_not be_valid
  end

  it 'emailが有効な形式であること' do
    valid_addresses = %w[client@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      client.email = valid_address
      expect(client).to be_valid
    end
  end

  it '無効な形式のemailは失敗すること' do
    invalid_addresses = %w[client@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      client.email = invalid_address
      expect(client).to_not be_valid
    end
  end

  it 'emailは小文字でDB登録されていること' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    client.email = mixed_case_email
    client.save
    expect(client.reload.email).to eq mixed_case_email.downcase
  end

  it 'passwordが必須であること' do
    client.password = client.password_confirmation = ' ' * 6
    expect(client).to_not be_valid
  end
 
  it 'passwordは6文字以上であること' do
    client.password = client.password_confirmation = 'a' * 5
    expect(client).to_not be_valid
  end
end
