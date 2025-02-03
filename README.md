# Hi, this is the product price app. This app should accept JSON file to upload and record product prices than list the filtering by country

# This project is a monolith with a RoRs API in backend and React in frontend.
# Frontend: https://github.com/GabrielVieiraDw/ProductPrices

## Technologies/prerequisites

This project was developed with the following technologies:

* Ruby '3.2.4'
* Rails '7.2.2'
* PostgreSQL '16'
* MongoDB '7.0.16'
* Sidekiq '7.3.8'
* Redis  '7.0.15'
* Bundler '2.4.19'

## Setup

After you get all the [prerequisites](#prerequisites), simply execute the following commands in sequence:

# Clone the repository:

git clone https://github.com/GabrielVieiraDw/ProductPricesApi.git

cd ProductPricesApi

# Install dependencies:

bundle install

# Configure the database:

Check datababe.yml.example

rails db:create db:migrate

Start the application:

rails s

Start Sidekiq for background jobs:

bundle exec sidekiq

## INFO

Endpoints da API

GET /prices "List prices"

GET /prices/:id "Get price

POST /prices JSON uplaod

## Expected JSON format

[ {
  "title" : "BIKE CARRIERS",
  "universeTitle" : "BIKE CARRIERS",
  "title2" : "BOSAL COMFORT PRO II GREY",
  "brand" : "BOSAL",
  "sku" : 110816,
  "model" : "COMFORT PRO II",
  "categoryId" : 572,
  "site" : "BE NL AMAZON.COM BE",
  "title3" : "BOSAL Trekhaak fietsendrager 500-002 trekhaak 1480 mm 600 mm 675 mm - B09QRB86JN",
  "site_id" : 997117,
  "country" : "belgium nl",
  "price" : 513.29,
  "variation" : 0.0,
  "availability" : true,
  "delivery" : 0,
  "url" : "https://www.amazon.com.be/BOSAL-Trekhaak-fietsendrager-500-002-trekhaak/dp/B09QRB86JN?language=fr_BE&tag=testachats22-21",
  "image" : "https://m.media-amazon.com/images/I/51kdVu38gXL._AC_SY300_SX300_.jpg",
  "modified" : "2024-09-17 01:46:29.0",
  "deliveryprice" : 0.0,
  "isbundle" : false,
  "ismarketplace" : true,
  "marketplaceseller" : "QUALITY-SHOPS BE NL AMAZON.COM BE",
  "wasPrice" : null,
  "referenceId" : 184885
} ]

### To run the tests:

- `bundle exec rspec`

# TODO

- Write documentation with Swagger
- add docker
- add authentications on API
- add authentication for users

---
Thanks for the opportunity, this was made with by Gabriel Vieira :wave:&nbsp; [Get in touch!](https://www.linkedin.com/in/gevvieira/)