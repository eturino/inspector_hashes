# InspectorHashes
[![Gem Version](https://badge.fury.io/rb/inspector_hashes.svg)](https://badge.fury.io/rb/inspector_hashes)
[![Build Status](https://travis-ci.org/eturino/inspector_hashes.svg?branch=master)](https://travis-ci.org/eturino/inspector_hashes)
[![Code Climate](https://codeclimate.com/github/eturino/inspector_hashes/badges/gpa.svg)](https://codeclimate.com/github/eturino/inspector_hashes)
[![Issue Count](https://codeclimate.com/github/eturino/inspector_hashes/badges/issue_count.svg)](https://codeclimate.com/github/eturino/inspector_hashes)
[![Test Coverage](https://codeclimate.com/github/eturino/inspector_hashes/badges/coverage.svg)](https://codeclimate.com/github/eturino/inspector_hashes/coverage)
[![Coverage Status](https://coveralls.io/repos/github/eturino/inspector_hashes/badge.svg?branch=master)](https://coveralls.io/github/eturino/inspector_hashes?branch=master)

## Requirements

requires ruby >= 2.1

Tested with:
  - 2.4.1
  - 2.3.3
  - 2.2.6
  - 2.1.10

## Description

Tests failing with huge responses that look basically the same? Don't really know where the issue is? If you try to use any string diff you can't see anything because all the errors are about key ordering in the hashes?


```ruby
expected_data = {"data"=>[{"id"=>"1", "type"=>"people", "attributes"=>{"client-key"=>"kassulke-lebsack-and-quitzon-9-ltd", "employment-type"=>"employee", "name"=>"Ewell Ledner", "skills"=>["even-keeled", "methodical"], "start-date"=>"2014-11-20", "job-title"=>"Arsonist", "team-names"=>["Tatooine"], "ed-date"=>nil, "created-at"=>"2017-04-04T23:20:47Z", "current-role-names"=>["Junior Developer"], "current-main-role-name"=>"Junior Developer", "updated-at"=>"2017-04-04T23:20:47Z", "current-project-keys"=>["rm"], "first-activity-date"=>"2017-01-17", "current-main-role-priority"=>1, "salary-currency"=>nil, "last-activity-date"=>"2017-03-29", "person-roles-info"=>[{"role-name"=>"Junior Developer", "project-key"=>"ada"}, {"role-name"=>"Junior Developer", "project-key"=>"bi"}, {"role-name"=>"Junior Developer", "project-key"=>"boatint"}, {"role-name"=>"Junior Developer", "project-key"=>"plink"}, {"role-name"=>"Junior Developer", "project-key"=>"plinkresp"}, {"role-name"=>"Junior Developer", "project-key"=>"mt"}, {"role-name"=>"Junior Developer", "project-key"=>"rm"}, {"role-name"=>"Junior Developer", "project-key"=>"rmyc"}], "salary-period"=>nil, "salary"=>nil, "account-usernames"=>["ledner.ewell"]}}, {"id"=>"2", "type"=>"people", "attributes"=>{"job-title"=>"Arsonist", "client-key"=>"kassulke-lebsack-and-quitzon-9-ltd", "name"=>"Rolando Huel", "team-names"=>[], "created-at"=>"2017-04-04T23:20:47Z", "employment-type"=>"contractor", "start-date"=>"2015-01-05", "end-date"=>nil, "updated-at"=>"2017-04-04T23:20:47Z", "current-main-role-priority"=>10, "current-main-role-name"=>"Director", "skills"=>["directional"], "current-project-keys"=>["mt"], "first-activity-date"=>"2017-02-24", "salary-period"=>nil, "last-activity-date"=>"2017-04-04", "person-roles-info"=>[{"role-name"=>"Director", "project-key"=>"ada"}, {"role-name"=>"Director", "project-key"=>"bi"}, {"role-name"=>"Director", "project-key"=>"boatint"}, {"role-name"=>"Director", "project-key"=>"plink"}, {"role-name"=>"Director", "project-key"=>"plinkresp"}, {"role-name"=>"Director", "project-key"=>"mt"}, {"role-name"=>"Director", "project-key"=>"rm"}, {"role-name"=>"Director", "project-key"=>"rmyc"}], "current-role-names"=>["Director"], "account-usernames"=>["rolando.huel", "rolando_huel"], "salary-currency"=>nil, "salary"=>nil}}], "meta"=>{"total"=>2, "size"=>100, "page"=>1, "offset"=>0, "ids"=>[1, 2], "facets"=>{"team-names"=>[{"value"=>"Tatooine", "count"=>1}], "names"=>[{"value"=>"Rolando Huel", "count"=>1}, {"value"=>"Ewell Ledner", "count"=>1}], "role-names"=>[{"value"=>"Director", "count"=>1}, {"value"=>"Junior Developer", "count"=>1}], "main-roles"=>[{"value"=>"Director", "count"=>1}, {"value"=>"Junior Developer", "count"=>1}], "project-keys"=>[{"value"=>"mt", "count"=>1}, {"value"=>"rm", "count"=>1}], "employment-types"=>[{"value"=>"contractor", "count"=>1}, {"value"=>"employee", "count"=>1}]}}}

response_data = {"data"=>[{"id"=>"1", "type"=>"people", "attributes"=>{"client-key"=>"kassulke-lebsack-and-quitzon-9-ltd", "name"=>"Ewell Ledner", "job-title"=>"Arsonist", "employment-type"=>"employee", "team-names"=>["Tatooine"], "start-date"=>"2014-11-20", "end-date"=>nil, "skills"=>["even-keeled", "methodical"], "created-at"=>"2017-04-04T23:20:47Z", "updated-at"=>"2017-04-04T23:20:47Z", "current-main-role-priority"=>1, "current-main-role-name"=>"Junior Developer", "current-project-keys"=>["rm"], "current-role-names"=>["Junior Developer"], "first-activity-date"=>"2017-01-17", "last-activity-date"=>"2017-03-29", "person-roles-info"=>[{"role-name"=>"Junior Developer", "project-key"=>"ada"}, {"role-name"=>"Junior Developer", "project-key"=>"bi"}, {"role-name"=>"Junior Developer", "project-key"=>"boatint"}, {"role-name"=>"Junior Developer", "project-key"=>"plink"}, {"role-name"=>"Junior Developer", "project-key"=>"plinkresp"}, {"role-name"=>"Junior Developer", "project-key"=>"mt"}, {"role-name"=>"Junior Developer", "project-key"=>"rm"}, {"role-name"=>"Junior Developer", "project-key"=>"rmyc"}], "account-usernames"=>["ledner.ewell"], "salary"=>nil, "salary-currency"=>nil, "salary-period"=>nil}}, {"id"=>"2", "type"=>"people", "attributes"=>{"client-key"=>"kassulke-lebsack-and-quitzon-9-ltd", "name"=>"Rolando Huel", "job-title"=>"Arsonist", "employment-type"=>"contractor", "team-names"=>[], "start-date"=>"2015-01-05", "end-date"=>nil, "skills"=>["directional"], "created-at"=>"2017-04-04T23:20:47Z", "updated-at"=>"2017-04-04T23:20:47Z", "current-main-role-priority"=>10, "current-main-role-name"=>"Director", "current-project-keys"=>["mt"], "current-role-names"=>["Director"], "first-activity-date"=>"2017-02-24", "last-activity-date"=>"2017-04-04", "person-roles-info"=>[{"role-name"=>"Director", "project-key"=>"ada"}, {"role-name"=>"Director", "project-key"=>"bi"}, {"role-name"=>"Director", "project-key"=>"boatint"}, {"role-name"=>"Director", "project-key"=>"plink"}, {"role-name"=>"Director", "project-key"=>"plinkresp"}, {"role-name"=>"Director", "project-key"=>"mt"}, {"role-name"=>"Director", "project-key"=>"rm"}, {"role-name"=>"Director", "project-key"=>"rmyc"}], "account-usernames"=>["rolando.huel", "rolando_huel"], "salary"=>nil, "salary-currency"=>nil, "salary-period"=>nil}}], "meta"=>{"total"=>2, "size"=>100, "page"=>1, "offset"=>0, "ids"=>[1, 2], "facets"=>{"team-names"=>[{"value"=>"Tatooine", "count"=>1}], "names"=>[{"value"=>"Rolando Huel", "count"=>1}, {"value"=>"Ewell Ledner", "count"=>1}], "role-names"=>[{"value"=>"Director", "count"=>1}, {"value"=>"Junior Developer", "count"=>1}], "main-roles"=>[{"value"=>"Director", "count"=>1}, {"value"=>"Junior Developer", "count"=>1}], "project-keys"=>[{"value"=>"mt", "count"=>1}, {"value"=>"rm", "count"=>1}], "employment-types"=>[{"value"=>"contractor", "count"=>1}, {"value"=>"employee", "count"=>1}]}}}

expected_data == response_data #=> false

```

But where?

A string diff is going to spot a lot of false positives just because the order of the keys in your expected data is not the same as the order of the keys in your response data. That's not really helpful. And Rspec will show something like

```
       -"data" => [{"id"=>"1", "type"=>"people", "attributes"=>{"client-key"=>"kassulke-lebsack-and-quitzon-9-ltd", "employment-type"=>"employee", "name"=>"Ewell Ledner", "skills"=>["even-keeled", "methodical"], "start-date"=>"2014-11-20", "job-title"=>"Arsonist", "team-names"=>["Tatooine"], "ed-date"=>nil, "created-at"=>"2017-04-04T23:20:47Z", "current-role-names"=>["Junior Developer"], "current-main-role-name"=>"Junior Developer", "updated-at"=>"2017-04-04T23:20:47Z", "current-project-keys"=>["rm"], "first-activity-date"=>"2017-01-17", "current-main-role-priority"=>1, "salary-currency"=>nil, "last-activity-date"=>"2017-03-29", "person-roles-info"=>[{"role-name"=>"Junior Developer", "project-key"=>"ada"}, {"role-name"=>"Junior Developer", "project-key"=>"bi"}, {"role-name"=>"Junior Developer", "project-key"=>"boatint"}, {"role-name"=>"Junior Developer", "project-key"=>"plink"}, {"role-name"=>"Junior Developer", "project-key"=>"plinkresp"}, {"role-name"=>"Junior Developer", "project-key"=>"mt"}, {"role-name"=>"Junior Developer", "project-key"=>"rm"}, {"role-name"=>"Junior Developer", "project-key"=>"rmyc"}], "salary-period"=>nil, "salary"=>nil, "account-usernames"=>["ledner.ewell"]}}, {"id"=>"2", "type"=>"people", "attributes"=>{"job-title"=>"Arsonist", "client-key"=>"kassulke-lebsack-and-quitzon-9-ltd", "name"=>"Rolando Huel", "team-names"=>[], "created-at"=>"2017-04-04T23:20:47Z", "employment-type"=>"contractor", "start-date"=>"2015-01-05", "end-date"=>nil, "updated-at"=>"2017-04-04T23:20:47Z", "current-main-role-priority"=>10, "current-main-role-name"=>"Director", "skills"=>["directional"], "current-project-keys"=>["mt"], "first-activity-date"=>"2017-02-24", "salary-period"=>nil, "last-activity-date"=>"2017-04-04", "person-roles-info"=>[{"role-name"=>"Director", "project-key"=>"ada"}, {"role-name"=>"Director", "project-key"=>"bi"}, {"role-name"=>"Director", "project-key"=>"boatint"}, {"role-name"=>"Director", "project-key"=>"plink"}, {"role-name"=>"Director", "project-key"=>"plinkresp"}, {"role-name"=>"Director", "project-key"=>"mt"}, {"role-name"=>"Director", "project-key"=>"rm"}, {"role-name"=>"Director", "project-key"=>"rmyc"}], "current-role-names"=>["Director"], "account-usernames"=>["rolando.huel", "rolando_huel"], "salary-currency"=>nil, "salary"=>nil}}],
       +"data" => [{"id"=>"1", "type"=>"people", "attributes"=>{"client-key"=>"kassulke-lebsack-and-quitzon-9-ltd", "name"=>"Ewell Ledner", "job-title"=>"Arsonist", "employment-type"=>"employee", "team-names"=>["Tatooine"], "start-date"=>"2014-11-20", "end-date"=>nil, "skills"=>["even-keeled", "methodical"], "created-at"=>"2017-04-04T23:20:47Z", "updated-at"=>"2017-04-04T23:20:47Z", "current-main-role-priority"=>1, "current-main-role-name"=>"Junior Developer", "current-project-keys"=>["rm"], "current-role-names"=>["Junior Developer"], "first-activity-date"=>"2017-01-17", "last-activity-date"=>"2017-03-29", "person-roles-info"=>[{"role-name"=>"Junior Developer", "project-key"=>"ada"}, {"role-name"=>"Junior Developer", "project-key"=>"bi"}, {"role-name"=>"Junior Developer", "project-key"=>"boatint"}, {"role-name"=>"Junior Developer", "project-key"=>"plink"}, {"role-name"=>"Junior Developer", "project-key"=>"plinkresp"}, {"role-name"=>"Junior Developer", "project-key"=>"mt"}, {"role-name"=>"Junior Developer", "project-key"=>"rm"}, {"role-name"=>"Junior Developer", "project-key"=>"rmyc"}], "account-usernames"=>["ledner.ewell"], "salary"=>nil, "salary-currency"=>nil, "salary-period"=>nil}}, {"id"=>"2", "type"=>"people", "attributes"=>{"client-key"=>"kassulke-lebsack-and-quitzon-9-ltd", "name"=>"Rolando Huel", "job-title"=>"Arsonist", "employment-type"=>"contractor", "team-names"=>[], "start-date"=>"2015-01-05", "end-date"=>nil, "skills"=>["directional"], "created-at"=>"2017-04-04T23:20:47Z", "updated-at"=>"2017-04-04T23:20:47Z", "current-main-role-priority"=>10, "current-main-role-name"=>"Director", "current-project-keys"=>["mt"], "current-role-names"=>["Director"], "first-activity-date"=>"2017-02-24", "last-activity-date"=>"2017-04-04", "person-roles-info"=>[{"role-name"=>"Director", "project-key"=>"ada"}, {"role-name"=>"Director", "project-key"=>"bi"}, {"role-name"=>"Director", "project-key"=>"boatint"}, {"role-name"=>"Director", "project-key"=>"plink"}, {"role-name"=>"Director", "project-key"=>"plinkresp"}, {"role-name"=>"Director", "project-key"=>"mt"}, {"role-name"=>"Director", "project-key"=>"rm"}, {"role-name"=>"Director", "project-key"=>"rmyc"}], "account-usernames"=>["rolando.huel", "rolando_huel"], "salary"=>nil, "salary-currency"=>nil, "salary-period"=>nil}}],
        "meta" => {"total"=>2, "size"=>100, "page"=>1, "offset"=>0, "ids"=>[1, 2], "facets"=>{"team-names"=>[{"value"=>"Tatooine", "count"=>1}], "names"=>[{"value"=>"Rolando Huel", "count"=>1}, {"value"=>"Ewell Ledner", "count"=>1}], "role-names"=>[{"value"=>"Director", "count"=>1}, {"value"=>"Junior Developer", "count"=>1}], "main-roles"=>[{"value"=>"Director", "count"=>1}, {"value"=>"Junior Developer", "count"=>1}], "project-keys"=>[{"value"=>"mt", "count"=>1}, {"value"=>"rm", "count"=>1}], "employment-types"=>[{"value"=>"contractor", "count"=>1}, {"value"=>"employee", "count"=>1}]}},
```

Which tells you that while `meta` is the same in both, `data` is different.

What you want is to spot that your expected data has a typo, and you expect `ed-date` instead of `end-date` in one of the objects. 

What you want is something like this:
```ruby
       # diff:
       [{:where=>"data > 0 > attributes > ed-date",
         :a=>nil,
         :b=>"<<<key not present>>>"},
        {:where=>"data > 0 > attributes > end-date",
         :a=>"<<<key not present>>>",
         :b=>nil}]
```

so in `data` array, in the first element (index `0`), in the hash `attributes`, you have misspelled `end-date`.
 
Notice that it has figure out that even when the expected value was `nil`.

## Usage

```ruby
diff = InspectorHashes.diff(something, similar)
```

the response of `InspectorHashes.diff` can be:
- `nil`: those 2 are equal (using `==`)
- a single "diff object" like `{ where: "", a: <something>, b: <similar> }`: the 2 objects are different, but they are not `Array` or `Hash`
- if both are `Array` or both are `Hash` instances, a list of "diff objects" showing the differences.

Note that it will use `==` to compare equality. For example, all of these are considered equivalent:
- `1` and `1.0`
- `[1, 2, 3]` and `[1, 2.0, 3]`

### `where` key

in a "diff object" the `where` value shows the path where the diff occurs. It's composed of the list of keys (in Hash) or index (in Array) that you have to follow to get there, separated by ` > `.

```ruby
diff = InspectorHashes.diff(something, similar)
#
# =>  [{:where=>"data > 0 > attributes > ed-date",
#       :a=>nil,
#       :b=>"<<<key not present>>>"},
#      {:where=>"data > 0 > attributes > end-date",
#       :a=>"<<<key not present>>>",
#       :b=>nil}]

first_where = 'data > 0 > attributes > ed-date'
first_a = a['data'][0]['attributes']['ed-date']
first_b = b['data'][0]['attributes']['ed-date']

```

note that if the key (or index) is not present in any of the objects, it will show `<<<key not present>>>`.

if they keys are symbols, where would look like:

```ruby
where_with_symbols_and_strings = 'data > 0 > :attributes > ed-date'
first_a = a['data'][0][:attributes]['ed-date']
first_b = b['data'][0][:attributes]['ed-date']

```

a string and a symbol are not considered equal: not in the values nor in the keys.

example of diff result:
```ruby
[
  # typo in a['data'][0]['attributes'] vs b['data'][0]['attributes'], 
  # one key is called `ed-date` and the other `end-date`
  { where: 'data > 0 > attributes > ed-date', a: nil, b: '<<<key not present>>>' },
  { where: 'data > 0 > attributes > end-date', a: '<<<key not present>>>', b: nil },

  # one value is a string, the other a symbol
  # a['meta']['facets']['employment-types'][1]['value'] == 'employee'
  # b['meta']['facets']['employment-types'][1]['value'] == :employee
  { where: 'meta > facets > employment-types > 1 > value', a: 'employee', b: :employee },

  # the order of the elements in the arrays are different:
  # a['meta']['ids'] == [2, 1]
  # b['meta']['ids'] == [1, 2]
  { where: 'meta > ids > 0', a: 2, b: 1 },
  { where: 'meta > ids > 1', a: 1, b: 2 },
  
  # `size` key is a string in a['meta'] and a symbol in b['meta']  
  { where: 'meta > size', a: 100, b: '<<<key not present>>>' },
  { where: 'meta > :size', a: '<<<key not present>>>', b: 100 },
]
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inspector_hashes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inspector_hashes

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eturino/inspector_hashes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Changelog

### v1.0.2

- specify min ruby version (2.1)

### v1.0.1

- minor changes in gemspec
- including gem version badge in README
