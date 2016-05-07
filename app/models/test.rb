class Test
  def test
    1
  end
end

Rspec.describe Test do
  describe '#test' do
    it 'should return 1 if given 1' do
      user = User.new
      result = user.test
      expect(result).to eq(1)
    end
  end 
end