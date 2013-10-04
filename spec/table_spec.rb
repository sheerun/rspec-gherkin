require 'spec_helper'

describe RspecGherkin::Table do
  let(:table) { described_class.new( raw ) }
  let(:raw) { [['foo', 'bar'], ['quox', '42']] }

  describe '#raw' do
    it 'returns the raw table' do
      table.raw.should == [['foo', 'bar'], ['quox', '42']]
    end

    it 'reflects changes in the raw table' do
      table.raw[1][1] = '55'
      table.raw.should == [['foo', 'bar'], ['quox', '55']]
    end
  end

  describe '#to_a' do
    it 'returns the raw table' do
      table.to_a.should == [['foo', 'bar'], ['quox', '42']]
    end
  end

  describe '#headers' do
    it 'returns the first row' do
      table.headers.should == ['foo', 'bar']
    end
  end

  describe '#rows' do
    let(:raw) { [['foo', 'bar'], ['moo', '55'], ['quox', '42']] }
    it 'returns the rows beyond the first' do
      table.rows.should == [['moo', '55'], ['quox', '42']]
    end
  end

  describe '#hashes' do
    let(:raw) { [['foo', 'bar'], ['moo', '55'], ['quox', '42']] }
    it 'returns a list of hashes based on the headers' do
      table.hashes.should == [
        {'foo' => 'moo', 'bar' => '55'},
        {'foo' => 'quox', 'bar' => '42'}
      ]
    end
  end

  describe '#map' do
    let(:raw) { [['moo', '55'], ['quox', '42']] }
    it 'iterates over the raw table' do
      table.map(&:first).should == ['moo', 'quox']
    end
  end

end
