# Rails Api for Ember Application w/ Authentication

Rails API for an art collection (to be used as a photo album or image gallery).

## API Structure

### Models

> User Model
>  include Authentication
>  has_many :collections
>  has_many :arts, through: :collections
>
>  validates :username, :email, :password_digest, uniqueness: true
>  validates :bio, length: { maximum: 500,
>    too_long: "%{count} characters is the maximum allowed" }

> Collection Model
>  has_many :arts
>  belongs_to :user
>
>  validates :image, presence: true
>  validates :desc, length: { maximum: 1000,
>    too_long: "%{count} characters is the maximum allowed" }

> Art Model
>  belongs_to :collection
>  belongs_to :user, through: :collections
>
>  validates :image, presence: true
>  validates :caption, length: { maximum: 250,
>    too_long: "%{count} characters is the maximum allowed" }

### DB Tables

users table

```Ruby
  t.string :email, null: false, index: { unique: true }
  t.string :token, null: false, index: { unique: true }
  t.string :password_digest, null: false

  t.string :username, index: { unique: true }
  t.string :first_name
  t.string :last_name
  t.text :bio
  t.string :image

  t.timestamps null: false
```

collections table

```Ruby
  t.string :name
  t.text :desc
  t.string :image

  t.references :user

  t.timestamps
```

arts table

```Ruby

  t.string :title
  t.text :caption
  t.string :image

  t.references :collection

  t.timestamps
```

### Routes

#### Authentication

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| PATCH  | `/change-password/:id` | `users#changepw`  |
| DELETE | `/sign-out/:id`        | `users#signout`   |

#### Users

| Verb  | URI Pattern  | Controller#Action |
|-------|--------------|-------------------|
| GET   | `/users`     | `users#index`     |
| GET   | `/users/:id` | `users#show`      |
| PATCH | `/users/:id` | `users#update`    |

#### Collections

| Verb   | URI Pattern        | Controller#Action     | Description             |
|--------|--------------------|-----------------------|-------------------------|
| GET    | `/collections`     | `collections#index`   | (R) display list of all |
| POST   | `/collections`     | `collections#create`  | Create new              |
| GET    | `/collections/:id` | `collections#show`    | (R) display specific    |
| PATCH  | `/collections/:id` | `collections#update`  | Update specific         |
| DELETE | `/collections/:id` | `collections#destroy` | Delete specific         |

#### Arts

| Verb   | URI Pattern | Controller#Action | Description             |
|--------|-------------|-------------------|-------------------------|
| GET    | `/arts`     | `arts#index`      | (R) display list of all |
| POST   | `/arts`     | `arts#create`     | Create new              |
| GET    | `/arts/:id` | `arts#show`       | (R) display specific    |
| PATCH  | `/arts/:id` | `arts#update`     | Update specific         |
| DELETE | `/arts/:id` | `arts#destroy`    | Delete specific         |

## Installation

1.  Install dependencies with `bundle install`.
1.  Setup database w/ `bin/rake db:nuke_pave` or `bundle exec rake db:nuke_pave`
1.  Run the API server with `bin/rails server` or `bundle exec rails server`.

## Tasks to run often

-   `rake routes` lists the endpoints available in your API.
-   `rake test` runs automated tests.
-   `rails console` opens a REPL that pre-loads the API.
-   `rails db` opens your database client and loads the correct database.
-   `rails server` starts the API.
-   `scripts/*.sh` run various `curl` commands to test the API. See below.

## API

Use this as the basis for your own API documentation. Add a new third-level
heading for your custom entities, and follow the pattern provided for the
built-in user authentication documentation.

Scripts are included in [`scripts`](scripts) to test built-in actions.
Add your own scripts to test your custom API.
As an alternative, you can write automated tests in RSpec to test your API.

### CURL

`curl` command scripts are stored in [`scripts`](scripts) with names that
correspond to API actions.

User authentication is built-in.

#### POST /sign-up

Request:

```sh
curl --include --request POST http://localhost:3000/sign-up \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "an@example.email",
      "password": "an example password",
      "password_confirmation": "an example password"
    }
  }'
```

```sh
scripts/sign-up.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "an@example.email"
  }
}
```

#### POST /sign-in

Request:

```sh
curl --include --request POST http://localhost:3000/sign-in \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "an@example.email",
      "password": "an example password"
    }
  }'
```

```sh
scripts/sign-in.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "an@example.email",
    "token": "33ad6372f795694b333ec5f329ebeaaa"
  }
}
```

#### PATCH /change-password/:id

Request:

```sh
curl --include --request PATCH http://localhost:3000/change-password/$ID \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "an example password",
      "new": "super sekrit"
    }
  }'
```

```sh
ID=1 TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/change-password.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

#### DELETE /sign-out/:id

Request:

```sh
curl --include --request DELETE http://localhost:3000/sign-out/$ID \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=1 TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/sign-out.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

#### GET /users

Request:

```sh
curl --include --request GET http://localhost:3000/users \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/users.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "users": [
    {
      "id": 2,
      "email": "another@example.email"
    },
    {
      "id": 1,
      "email": "an@example.email"
    }
  ]
}
```

#### GET /users/:id

Request:

```sh
curl --include --request GET http://localhost:3000/users/$ID \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=2 TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/user.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 2,
    "email": "another@example.email"
  }
}
```

## Steps Taken

1.  `rails g scaffold collection`, and `rails g scaffold art`
1.  looked over scaffold, filled in with models and table migrations
1.  added update to users_controller

## Useful Links

-   [Ruby on Rails Guide](http://guides.rubyonrails.org/)
-   [Github rails-api](https://github.com/rails-api/rails-api)
-   [Github Rails](https://github.com/rails/rails)
-   [active_model_serializers](https://github.com/rails-api/active_model_serializers)
-   [Ruby](https://www.ruby-lang.org/en/)
-   [Postgres](http://www.postgresql.org)

## [License](LICENSE)

Source code distributed under the MIT license. Text and other assets copyright
General Assembly, Inc., all rights reserved.
