require 'spec_helper'

# rubocop:disable LineLength
# rubocop:disable BlockLength

RSpec.describe InspectorHashes do
  it 'has a version number' do
    expect(InspectorHashes::VERSION).not_to be nil
  end

  describe '.diff' do
    context 'simple elements' do
      context 'equal elements' do
        context 'nil' do
          let(:a) { nil }
          let(:b) { nil }

          it { expect(InspectorHashes.diff(a, b)).to be_nil }
        end

        context '""' do
          let(:a) { '' }
          let(:b) { '' }

          it { expect(InspectorHashes.diff(a, b)).to be_nil }
        end

        context '1 and 1' do
          let(:a) { 1 }
          let(:b) { 1 }

          it { expect(InspectorHashes.diff(a, b)).to be_nil }
        end

        context '1 and 1.0' do
          let(:a) { 1 }
          let(:b) { 1.0 }

          it { expect(InspectorHashes.diff(a, b)).to be_nil }
        end
      end

      context 'different elements' do
        context 'blank and nil' do
          let(:a) { '' }
          let(:b) { nil }

          let(:expected) do
            { where: '', a: a, b: b }
          end

          it { expect(InspectorHashes.diff(a, b)).to eq expected }
        end
        context '"1" and 1' do
          let(:a) { '1' }
          let(:b) { 1 }

          let(:expected) do
            { where: '', a: a, b: b }
          end

          it { expect(InspectorHashes.diff(a, b)).to eq expected }
        end
      end
    end

    context 'arrays or hashes => result will be nil if equal or an array with the nested differences' do
      context 'treated as equal' do
        context '[1, 2, 3] and [1.0, 2.0, 3.0]' do
          let(:a) { [1, 2, 3] }
          let(:b) { [1.0, 2.0, 3.0] }

          it { expect(InspectorHashes.diff(a, b)).to be_nil }
        end

        context '[1, { a: "a", b: "b" }, 3] and [1.0, { b: "b", a: "a" }, 3.0]' do
          let(:a) { [1, { a: 'a', b: 'b' }, 3] }
          let(:b) { [1.0, { b: 'b', a: 'a' }, 3.0] }

          it { expect(InspectorHashes.diff(a, b)).to be_nil }
        end

        context '{ a: "a", b: "b" }, { b: "b", a: "a" }] (ignores hash order)' do
          let(:a) { { a: 'a', b: 'b' } }
          let(:b) { { b: 'b', a: 'a' } }

          it { expect(InspectorHashes.diff(a, b)).to be_nil }
        end
      end

      context 'differences' do
        context '[1, 4, 3] and [1.0, 2.0, 3.0]' do
          let(:a) { [1, 4, 3] }
          let(:b) { [1.0, 2.0, 3.0] }

          let(:expected) do
            [
              { where: '1', a: 4, b: 2.0 }
            ]
          end

          it { expect(InspectorHashes.diff(a, b)).to eq expected }
        end

        context '[3, 1, 2] and [2.0, 1.0, 3.0]' do
          let(:a) { [3, 1, 2] }
          let(:b) { [2.0, 1.0, 3.0] }

          let(:expected) do
            [
              { where: '0', a: 3, b: 2.0 },
              { where: '2', a: 2, b: 3.0 },
            ]
          end

          it { expect(InspectorHashes.diff(a, b)).to eq expected }
        end

        context '{ some: "a", thing: "b" }, { thing: "b", some: "a" }] (ignores hash order)' do
          let(:a) { { some: :a, thing: 'b' } }
          let(:b) { { thing: 'b', some: 'a' } }

          let(:expected) do
            [
              { where: ':some', a: :a, b: 'a' }
            ]
          end

          it { expect(InspectorHashes.diff(a, b)).to eq expected }
        end
      end
    end
  end
end
