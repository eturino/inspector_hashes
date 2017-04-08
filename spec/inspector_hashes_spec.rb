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

        context 'complex nested: finding typos, order in array, symbols vs strings in keys and in values' do
          let(:a) do
            {
              'data' => [
                {
                  'id' => '1',
                  'type' => 'people',
                  'attributes' => {
                    'client-key' => 'kassulke-lebsack-and-quitzon-9-ltd',
                    'employment-type' => 'employee',
                    'name' => 'Ewell Ledner',
                    'skills' => [
                      'even-keeled',
                      'methodical'
                    ],
                    'start-date' => '2014-11-20',
                    'job-title' => 'Arsonist',
                    'team-names' => ['Tatooine'],
                    'ed-date' => nil,
                    'created-at' => '2017-04-04T23:20:47Z',
                    'current-role-names' => ['Junior Developer'],
                    'current-main-role-name' => 'Junior Developer',
                    'updated-at' => '2017-04-04T23:20:47Z',
                    'current-project-keys' => ['rm'],
                    'first-activity-date' => '2017-01-17',
                    'current-main-role-priority' => 1,
                    'salary-currency' => nil,
                    'last-activity-date' => '2017-03-29',
                    'person-roles-info' => [
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'ada'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'bi'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'boatint'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'plink'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'plinkresp'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'mt'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'rm'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'rmyc'
                      }
                    ],
                    'salary-period' => nil,
                    'salary' => nil,
                    'account-usernames' => ['ledner.ewell']
                  }
                },
                {
                  'id' => '2',
                  'type' => 'people',
                  'attributes' => {
                    'job-title' => 'Arsonist',
                    'client-key' => 'kassulke-lebsack-and-quitzon-9-ltd',
                    'name' => 'Rolando Huel',
                    'team-names' => [],
                    'created-at' => '2017-04-04T23:20:47Z',
                    'employment-type' => 'contractor',
                    'start-date' => '2015-01-05',
                    'end-date' => nil, 'updated-at' => '2017-04-04T23:20:47Z',
                    'current-main-role-priority' => 10,
                    'current-main-role-name' => 'Director',
                    'skills' => ['directional'],
                    'current-project-keys' => ['mt'],
                    'first-activity-date' => '2017-02-24',
                    'salary-period' => nil,
                    'last-activity-date' => '2017-04-04',
                    'person-roles-info' => [
                      {
                        'role-name' => 'Director',
                        'project-key' => 'ada'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'bi'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'boatint'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'plink'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'plinkresp'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'mt'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'rm'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'rmyc'
                      }
                    ],
                    'current-role-names' => ['Director'],
                    'account-usernames' => [
                      'rolando.huel',
                      'rolando_huel'
                    ],
                    'salary-currency' => nil,
                    'salary' => nil
                  }
                }
              ],
              'meta' => {
                'total' => 2.0,
                'size' => 100,
                'page' => 1,
                'offset' => 0,
                'ids' => [3, 2, 1, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 13],
                'facets' => {
                  'team-names' => [
                    {
                      'value' => 'Tatooine',
                      'count' => 1
                    }
                  ],
                  'names' => [
                    {
                      'value' => 'Rolando Huel',
                      'count' => 1
                    },
                    {
                      'value' => 'Ewell Ledner',
                      'count' => 1
                    }
                  ],
                  'role-names' => [
                    {
                      'value' => 'Director',
                      'count' => 1
                    },
                    {
                      'value' => 'Junior Developer',
                      'count' => 1
                    }
                  ],
                  'main-roles' => [
                    {
                      'value' => 'Director',
                      'count' => 1
                    },
                    {
                      'value' => 'Junior Developer',
                      'count' => 1
                    }
                  ],
                  'project-keys' => [
                    {
                      'value' => 'mt',
                      'count' => 1
                    },
                    {
                      'value' => 'rm',
                      'count' => 1
                    }
                  ],
                  'employment-types' => [
                    {
                      'value' => 'contractor',
                      'count' => 1
                    },
                    {
                      'value' => 'employee',
                      'count' => 1
                    }
                  ]
                }
              }
            }
          end

          let(:b) do
            {
              'data' => [
                {
                  'id' => '1',
                  'type' => 'people',
                  'attributes' => {
                    'client-key' => 'kassulke-lebsack-and-quitzon-9-ltd',
                    'employment-type' => 'employee',
                    'name' => 'Ewell Ledner',
                    'skills' => [
                      'even-keeled',
                      'methodical'
                    ],
                    'start-date' => '2014-11-20',
                    'job-title' => 'Arsonist',
                    'team-names' => ['Tatooine'],
                    'end-date' => nil,
                    'created-at' => '2017-04-04T23:20:47Z',
                    'current-role-names' => ['Junior Developer'],
                    'current-main-role-name' => 'Junior Developer',
                    'updated-at' => '2017-04-04T23:20:47Z',
                    'current-project-keys' => ['rm'],
                    'first-activity-date' => '2017-01-17',
                    'current-main-role-priority' => 1,
                    'salary-currency' => nil,
                    'last-activity-date' => '2017-03-29',
                    'person-roles-info' => [
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'ada'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'bi'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'boatint'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'plink'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'plinkresp'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'mt'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'rm'
                      },
                      {
                        'role-name' => 'Junior Developer',
                        'project-key' => 'rmyc'
                      }
                    ],
                    'salary-period' => nil,
                    'salary' => nil,
                    'account-usernames' => ['ledner.ewell']
                  }
                },
                {
                  'id' => '2',
                  'type' => 'people',
                  'attributes' => {
                    'job-title' => 'Arsonist',
                    'client-key' => 'kassulke-lebsack-and-quitzon-9-ltd',
                    'name' => 'Rolando Huel',
                    'team-names' => [],
                    'created-at' => '2017-04-04T23:20:47Z',
                    'employment-type' => 'contractor',
                    'start-date' => '2015-01-05',
                    'end-date' => nil, 'updated-at' => '2017-04-04T23:20:47Z',
                    'current-main-role-priority' => 10,
                    'current-main-role-name' => 'Director',
                    'skills' => ['directional'],
                    'current-project-keys' => ['mt'],
                    'first-activity-date' => '2017-02-24',
                    'salary-period' => nil,
                    'last-activity-date' => '2017-04-04',
                    'person-roles-info' => [
                      {
                        'role-name' => 'Director',
                        'project-key' => 'ada'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'bi'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'boatint'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'plink'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'plinkresp'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'mt'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'rm'
                      },
                      {
                        'role-name' => 'Director',
                        'project-key' => 'rmyc'
                      }
                    ],
                    'current-role-names' => ['Director'],
                    'account-usernames' => [
                      'rolando.huel',
                      'rolando_huel'
                    ],
                    'salary-currency' => nil,
                    'salary' => nil
                  }
                }
              ],
              'meta' => {
                'total' => 2,
                size: 100,
                'page' => 1,
                'offset' => 0,
                'ids' => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                'facets' => {
                  'team-names' => [
                    {
                      'value' => 'Tatooine',
                      'count' => 1
                    }
                  ],
                  'names' => [
                    {
                      'value' => 'Rolando Huel',
                      'count' => 1
                    },
                    {
                      'value' => 'Ewell Ledner',
                      'count' => 1
                    }
                  ],
                  'role-names' => [
                    {
                      'value' => 'Director',
                      'count' => 1
                    },
                    {
                      'value' => 'Junior Developer',
                      'count' => 1
                    }
                  ],
                  'main-roles' => [
                    {
                      'value' => 'Director',
                      'count' => 1
                    },
                    {
                      'value' => 'Junior Developer',
                      'count' => 1
                    }
                  ],
                  'project-keys' => [
                    {
                      'value' => 'mt',
                      'count' => 1
                    },
                    {
                      'value' => 'rm',
                      'count' => 1
                    }
                  ],
                  'employment-types' => [
                    {
                      'value' => 'contractor',
                      'count' => 1
                    },
                    {
                      'value' => :employee,
                      'count' => 1
                    }
                  ]
                }
              }
            }
          end

          let(:expected) do
            [
              { where: 'data > 0 > attributes > ed-date', a: nil, b: '<<<key not present>>>' },
              { where: 'data > 0 > attributes > end-date', a: '<<<key not present>>>', b: nil },
              { where: 'meta > facets > employment-types > 1 > value', a: 'employee', b: :employee },
              { where: 'meta > ids > 0', a: 3, b: 1 },
              { where: 'meta > ids > 2', a: 1, b: 3 },
              { where: 'meta > ids > 12', a: 14, b: 13 },
              { where: 'meta > ids > 13', a: 13, b: 14 },
              { where: 'meta > size', a: 100, b: '<<<key not present>>>' },
              { where: 'meta > :size', a: '<<<key not present>>>', b: 100 },
            ]
          end

          it { expect(InspectorHashes.diff(a, b)).to eq expected }
        end
      end
    end
  end
end
