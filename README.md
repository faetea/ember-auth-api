# Rails Api for Ember Application w/ Authentication

Rails API for an art collection (to be used as a photo album or image gallery).

## API Structure

### Models

User Model

```ruby
include Authentication
has_many :collections, dependent: :destroy
# validates :username, :email, :password_digest, uniqueness: true
# validates :bio, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
```

Collection Model

```ruby
belongs_to :user
has_many :arts, dependent: :destroy
# validates :image, presence: true
# validates :desc, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }
```

Art Model

```ruby
belongs_to :collection
# validates :image, presence: true
# validates :caption, length: { maximum: 250, too_long: "%{count} characters is the maximum allowed" }
```

### DB Tables

users table

```ruby
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

```ruby
  t.string :name
  t.text :desc
  t.string :image

  t.references :user
  t.timestamps
```

arts table

```ruby
  t.string :title
  t.text :caption
  t.string :image

  t.references :collection
  t.timestamps
```

### Routes

-   PUT is a direct modification even if fields/inputs are null/undefined
-   PATCH only changes fields that are mentioned

#### Arts

| Verb   | URI Pattern | Controller#Action |
| -------|-------------|------------------ |
| GET    | `/arts`     | `arts#index`      |
| POST   | `/arts`     | `arts#create`     |
| GET    | `/arts/:id` | `arts#show`       |
| PATCH  | `/arts/:id` | `arts#update`     |
| DELETE | `/arts/:id` | `arts#destroy`    |

#### Collections

| Verb   | URI Pattern        | Controller#Action     |
| -------|--------------------|---------------------- |
| GET    | `/collections`     | `collections#index`   |
| POST   | `/collections`     | `collections#create`  |
| GET    | `/collections/:id` | `collections#show`    |
| PATCH  | `/collections/:id` | `collections#update`  |
| DELETE | `/collections/:id` | `collections#destroy` |

#### Users

| Verb  | URI Pattern  | Controller#Action |
| ------|--------------|------------------ |
| GET   | `/users`     | `users#index`     |
| GET   | `/users/:id` | `users#show`      |
| PATCH | `/users/:id` | `users#update`    |
| PUT   | `/users/:id` | `users#update`    |

#### Authentication

| Verb   | URI Pattern            | Controller#Action |
| -------|------------------------|------------------ |
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| PATCH  | `/change-password/:id` | `users#changepw`  |
| DELETE | `/sign-out/:id`        | `users#signout`   |

## Installation

1.  Install dependencies with `bundle install`.
1.  Setup database w/ `bundle exec rake db:nuke_pave` or `bin/rake db:nuke_pave`
1.  Run the API server with `bundle exec rails server` or `bin/rails server`

## CURL Documentation

Scripts are included in [`scripts`](scripts) to test built-in actions.
As an alternative, write automated tests in RSpec to test API.
User authentication is built-in.

## Tasks to run often

-   `bundle exec rake routes` lists the endpoints available in your API.
-   `rake test` runs automated tests.
-   `rails console` opens a REPL that pre-loads the API.
-   `rails db` opens your database client and loads the correct database.
-   `rails server` starts the API.
-   `scripts/*.sh` run various `curl` commands to test the API.

## Steps Taken

1.  `rails g scaffold collection`, and `rails g scaffold art`
1.  looked over scaffold, filled in with models and table migrations
1.  added update to users_controller
1.  need to write controller actions
1.  wrote update actions for users and collections, untested
1.  Scott explained `chmod 755 *.sh` will make my new curl scripts runable
1.  fixed update action for users!
1.  tested update and delete on collections_controller with curl

## Paperclip

Paperclip is now compatible with aws-sdk >= 2.0.0.

If you are using S3 storage, aws-sdk >= 2.0.0 requires you to make a few small
changes:

-   You must set the `s3_region`
-   If setting permissions anywhere, such as in an initializer,
the format for permissions changed from underscore to hyphen.
For example, `:public_read` needs to be changed to `public-read`.

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
