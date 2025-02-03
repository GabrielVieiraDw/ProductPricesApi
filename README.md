<h1 align="center">
    <p><span style="color:#00f0a2">Product Prices</span></p>
</h1>

<h3 align="center">
  Hi, this is the product price app. This app should accept JSON file to upload and record product prices than list the filtering by country.
</h3>

<p align="center">This project is a monolith with a Ruby on Rails API in the backend and React in the frontend.</p>
<p align="center">Front repository: https://github.com/GabrielVieiraDw/ProductPrices</p>

---

## Prerequisites

Have the following features with their respective versions installed on the machine:

- Ruby `3.2.4` - You can use [RVM](http://rvm.io)
- PostgreSQL 16
  - OSX - `$ brew install postgresql` or install [Postgress.app](http://postgresapp.com/)
  - Linux - `$ sudo apt-get install postgresql`
  - Windows - [PostgreSQL for Windows](http://www.postgresql.org/download/windows/)
- MongoDB `7.0.16`
- Bundler `2.4.19`

## Setup the project

After you get all the [prerequisites](#prerequisites), simply execute the following commands in sequence:

```bash
1. Install the dependencies above
2. $ git clone  # Clone the project
3. $ cd ProductPricesApi # Go into the project folder
4. $ gem install bundler # Bundler install
5. $ bundle install # Install ruby dependencies
6. $ check database.yml.example # Config database
7. $ rake db:create # Creates db
8. $ rake db:migrate # Migrates db
9. $ rspec spec # Run the specs to see if everything is working fine
```

## Feature improvements for next releases

- Write documentation with Swagger
- add docker
- add authentications on API
- API to pre signed upload;
- Job download, read and process file

---
Thanks for the opportunity, this was made with by Gabriel Vieira :wave:&nbsp; [Get in touch!](https://www.linkedin.com/in/gevvieira/)
