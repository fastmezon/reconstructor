require 'spec_helper'

describe CoefCalc do
  let(:wkt_reader) { Geos::WktReader.new}

  describe '.gen_pixel' do
    let(:pixel) { wkt_reader.read('POLYGON((0.5 0.5, 1.5 0.5, 1.5 1.5, 0.5 1.5, 0.5 0.5))') }
    it { expect(subject).to respond_to(:gen_pixel).with(3).arguments }

    it 'return correct pixel' do
      expect(subject.gen_pixel(0.5,0.5,1)).to eq(pixel)
    end
  end

  describe '.gen_scope' do
    let(:polygon) { wkt_reader.read('POLYGON((1 -2, 0 -2, 0 2, 1 2, 1 -2))') }

    it { expect(subject).to respond_to(:gen_scope).with(4).arguments }

    it 'return correct polygon' do
      expect(subject.gen_scope(0, -1, 2, Math::PI)).to be_almost_equals(polygon)
    end

  end

end
