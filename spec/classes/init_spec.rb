require 'spec_helper'
describe 'ucs' do
  context 'with default values for all parameters' do
    it { should contain_class('ucs') }
  end
end
