# install

1. build containers

   `docker-compose build`

1. start containers in background

   `docker-compose up -d`

1. connect to rails service

   ```
   docker-compose exec memory_app_back bash
   bundle install
   rake db:setup
   rspec -> you can see coverage on "volume/blog-backend/coverage/index.html"
   railss
   ```

1. access

   `http://localhost:3333`

1. Semaphore

   [![Build Status](https://semaphoreci.com/api/v1/edimossilva/memory-app-rails/branches/master/badge.svg)](https://semaphoreci.com/edimossilva/memory-app-rails)
