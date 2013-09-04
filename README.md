Toggl API Ruby Client
=======
# TogglApi

A Ruby interface to the [Toggl](https://github.com/toggl/toggl_api_docs/blob/master/toggl_api.md) and [Reports](https://github.com/toggl/toggl_api_docs/blob/master/reports.md) API 

## Installation

Add this line to your application's Gemfile:

    gem 'toggl_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install toggl_api

## Usage

### Base Api

     base = Toggl::Base.new "2a9800b95ef1d8d2b61d630f5df448f8" 

     base.me(true) ##will return current user data with related data, default is false

     base.time_entries(Date.today) ##return today's entries

     entries = base.time_entries(Date.today - 1, Date.today) ##return yesterday's entries
     entries.first.description ##get description for the first entry

### Report Api

     report = Toggl::Report.new "2a9800b95ef1d8d2b61d630f5df448f8" 

     report.weekly('wid')
     report.details('wid')
     report.summary('wid')

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
