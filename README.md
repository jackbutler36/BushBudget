# README

After cloning this repo for development purposes, run(assuming you're on Windows)

* docker run --rm -it --volume "${PWD}:/csce431" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest

* cd csce431

* bundle install

* rails webpacker:install

* rails db:create db:migrate db:seed

* rails server --binding=0.0.0.0

To see credentials for Admin testing, see db/seed.rb
