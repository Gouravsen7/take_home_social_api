# README

## Required Environment / Minimum Setup

Ruby version is `2.6.5`.
Rails version is `6.1`.

Minimum setup required to run the app:

```shell
git clone https://github.com/Gouravsen7/take_home_social_api.git
cd take_home_social_api
bundle install

# NOTE: need to fill in the ENV values by below mentioned command. Need to setup below mentioned variables.
#  feed_base_url: https://takehome.io

EDITOR=vim rails credentials:edit

# SetUp database
rails db:create db:migrate

# Start the rails server using
rails server
```

## Testing

Run the test suite to confirm if the setup is successful.

Make sure that the test database is prepared:

```shell
RAILS_ENV=test rails db:structure:load
```

Then run test suites:

```shell
rspec
```

## Details of Implementation
* Using `takehome.io` to fetch data for all three social media platforms: Facebook, Twitter, Instagram.
* If the response code is 200, then the response body getting parsed.
* In case the response code is not 200 for a request to a particular social network which indicates something went be wrong, then I am adding this value: `[{ error_message: 'Something went wrong.' }]`
* Connection timeouts are also handled explicitly and the error message in this case.
`[{ error_message: 'Connection timed out.' }]`
* You can change error messages by changing in the `en.yml` file.
