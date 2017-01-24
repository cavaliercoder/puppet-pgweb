require 'spec_helper'
describe 'pgweb' do
  context 'with default values for all parameters' do
    it { should contain_class('pgweb') }
  end
end
