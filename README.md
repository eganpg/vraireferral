Shopify Referral Program

This is a rails app designed to create a referral program add on for shopify stores

## Mechanics

Prelaunchr has a main mechanic from which everything else is derived: Every `User` is given a unique `referral_code` which is how the application knows who referred a signing up user. Based on the amount of referrals a `User` has brought to the site, they are put into a different "prize group". The groups, amounts, and prizes are completely up to you to set. 

## IP Blocking

By default, we block more than 2 sign-ups from the same IP address. This was simplistic, but was good enough for us during our campaign. If you want something more substantial take a look at [Rack::Attack](https://github.com/kickstarter/rack-attack)

## Setup

* Follow the standard Rails 3.2.x setup tasks over at the [Rails GitHub](https://github.com/rails/rails/tree/v3.2.17), basically `bundle install` in this directory.
* Run `bundle exec rake db:create db:schema:load db:seed` to setup the database
* Type `bundle exec rails s` to startup the Rails Server
  * For convenience we have also bundled a Heroku Procfile to use on production. This uses [Unicorn](https://github.com/defunkt/unicorn) for the web server and runs a [Delayed::Job](https://github.com/collectiveidea/delayed_job) worker for sending email. 


## Configuration

* Change the default Admin user credentials in `/db/seeds.rb`
* Set the different prize levels on the `User::REFERRAL_STEPS` constant inside `/app/models/user.rb`
* Run `rake secret` to generate a new Rails `secret_token` and set it in `/config/intializers/secret_token.rb` (or in the `RAILS_SECRET` environment variable).
* The `config.ended` setting in `/config/application.rb` decides whether the prelaunch campaign has ended or not (e.g. Active/Inactive). We've included this option so you can quickly close the application and direct users to your newly launched site. 

## License

The code, documentation, non-branded copy and configuration are released under
the MIT license. Any branded assets are included only to illustrate and inspire.

Please change the artwork to use your own brand! Vrai and Oro do not give
you permission to use our brand or trademarks in your own marketing.
