require 'rails_helper'

# RSpec.describe User, type: :model do

describe User do
  it 'returns 1 if given 1' do
    result = '1'
    expect(result).to eq('1')
  end

  it 'is valid with a name, oauth_token and oauth_secret' do
    user = User.new(
      name: 'test',
      oauth_token: 'test',
      oauth_secret: 'test'
    )
    expect(user).to be_valid
  end

  # describe 'test' do
  #   it 'should return https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball 
  #   if given https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball' do
  #     output = User.new
  #     result = output.test('https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball')
  #     expect(result).to eq('https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball')
  #   end
  # end 

  # describe 'test' do
  #   it 'should return a shortened link
  #   if given a url' do
  #     output = User.new
  #     result = output.test('https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball')
  #     expect(result).to eq(Shortener::ShortenedUrl.generate("https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball"))
  #   end
  # end 
end
