#!/bin/bash

curl --include --request POST http://localhost:3000/sign-up \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "star@hub",
      "password": "fire",
      "password_confirmation": "fire"
    }
  }'

curl --include --request POST http://localhost:3000/sign-up \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "moon@hub",
      "password": "bun",
      "password_confirmation": "bun"
    }
  }'

curl --include --request POST http://localhost:3000/sign-up \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "carrot@hub",
      "password": "soap",
      "password_confirmation": "soap"
    }
  }'
