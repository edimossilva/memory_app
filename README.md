# Read Me
1. Semaphore (parallel tests / lint)

   [![Build Status](https://edimossilva.semaphoreci.com/badges/memory_app/branches/master.svg?style=shields)](https://edimossilva.semaphoreci.com/projects/memory_app)

1. Code-climate - Test Coverage

   [![Test Coverage](https://api.codeclimate.com/v1/badges/acf7bd7bd4f5d1a4e7bc/test_coverage)](https://codeclimate.com/github/edimossilva/memory_app/test_coverage)

1. Code-climate - Maintainability

   [![Maintainability](https://api.codeclimate.com/v1/badges/acf7bd7bd4f5d1a4e7bc/maintainability)](https://codeclimate.com/github/edimossilva/memory_app/maintainability)

1. Heroku

   https://memory-app-back.herokuapp.com/

1. Swagger

   https://memory-app-back.herokuapp.com/api-docs/index.html

1. Docker images

   https://hub.docker.com/repository/docker/edimossilva/memory_app_rails
   https://hub.docker.com/repository/docker/edimossilva/memory_app_vue
   https://hub.docker.com/repository/docker/edimossilva/memory_e2e
## Install
1. create .env files from template
    `cp frontend_vue/.env.example frontend_vue/.env`
    `cp backend_rails/.env.example backend_rails/.env`
1. start containers in background (only use images)

   `docker-compose up -d`
   `docker-compose ps` => should see "State=Up" for all containers

1. config db

   `docker-compose exec memory_app_back rake db:create db:migrate db:seed`

1. tests backend unit

   `docker-compose exec memory_app_back rspec`


1. tests frontend e2e

   `docker-compose exec memory_app_e2e xvfb-run -a cypress run`

1. access frontend client

   `http://localhost:8080` => username: registered_user1, password: 111

1. access admin
   `http://localhost:3000/admin` => username: admin, password: admin


