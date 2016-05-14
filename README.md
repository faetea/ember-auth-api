# Rails Api for Ember Application w/ Authentication

Rails API for an art collection (to be used as a photo album or image gallery).

## Installation

1.  Install dependencies with `bundle install`.
1.  Setup database w/ `bundle exec rake db:nuke_pave` or `bin/rake db:nuke_pave`
1.  Run the API server with `bundle exec rails server` or `bin/rails server`

## Routes

-   PUT is a direct modification even if fields/inputs are null/undefined
-   PATCH only changes fields that are mentioned

| Verb      | URI Pattern            | Controller#Action     |
|-----------|------------------------|-----------------------|
| POST      | `/sign-up`             | `users#signup`        |
| POST      | `/sign-in`             | `users#signin`        |
| PATCH     | `/change-password/:id` | `users#changepw`      |
| DELETE    | `/sign-out/:id`        | `users#signout`       |
| GET       | `/users`               | `users#index`         |
| GET       | `/users/:id`           | `users#show`          |
| PATCH     | `/users/:id`           | `users#update`        |
| PUT       | `/users/:id`           | `users#update`        |
| GET       | `/collections`         | `collections#index`   |
| POST      | `/collections`         | `collections#create`  |
| GET       | `/collections/:id`     | `collections#show`    |
| PUT/PATCH | `/collections/:id`     | `collections#update`  |
| DELETE    | `/collections/:id`     | `collections#destroy` |
| GET       | `/arts`                | `arts#index`          |
| POST      | `/arts`                | `arts#create`         |
| GET       | `/arts/:id`            | `arts#show`           |
| PUT/PATCH | `/arts/:id`            | `arts#update`         |
| DELETE    | `/arts/:id`            | `arts#destroy`        |

## CURL Documentation

Scripts are included in [`scripts`](scripts) to test built-in actions.
As an alternative, write automated tests in RSpec to test API.
User authentication is built-in.

## GEMs

### Paperclip

Paperclip is now compatible with aws-sdk >= 2.0.0.
If you are using S3 storage, aws-sdk >= 2.0.0 requires you to make a few small
changes:

-   You must set the `s3_region`
-   If setting permissions anywhere, such as in an initializer,
the format for permissions changed from underscore to hyphen.
For example, `:public_read` needs to be changed to `public-read`.

-   [Github Paperclip](https://github.com/thoughtbot/paperclip)
-   [Heroku Paperclip S3](https://devcenter.heroku.com/articles/paperclip-s3)
-   [Rubydoc Paperclip S3](http://www.rubydoc.info/gems/paperclip/Paperclip/Storage/S3)
-   [Github AWS SDK Ruby](https://github.com/aws/aws-sdk-ruby)

### active_model_serializers

This app is using [active_model_serializers](https://github.com/rails-api/active_model_serializers)
to communicate with Ember's active-model-adapter.

"convention over configuration" with JSON.
AMS works through serializers and adapters;
Serializers describe WHICH attributes and relationships should be serialized.
Adapters describe HOW attributes and relationships should be serialized.

When /collections in Ember `return this.get('store').findAll('collection')`
AMS will respond with all Collections, but no Art objects

```json
{
  "collections":
  [
    {
      "id":1,
      "name":"neighbor",
      "desc":"totoro",
      "user_id":1,
      "cover":"http://s3.amazonaws.com/faetea-artcollection/collections/covers/000/000/001/original/1461623034.png?1461623034",
      "art_ids":[1,2,3,4,5,8,9,10,11,12,13]
    },
    {
      "id":2,
      "name":"timey",
      "desc":"whimey",
      "user_id":2,
      "cover":"http://s3.amazonaws.com/faetea-artcollection/collections/covers/000/000/002/original/1461624382.png?1461624382",
      "art_ids":[6,7,14]
    },
    {
      "id":3,
      "name":"Walkabout",
      "desc":"good wandering",
      "user_id":3,
      "cover":"http://s3.amazonaws.com/faetea-artcollection/collections/covers/000/000/003/original/1462241650.png?1462241650",
      "art_ids":[15]
    }
  ]
}
```

When /collections/1 in Ember `collection.id`
AMS will respond with the specific Collection

```json
{
  "collection":
  {
    "id":1,
    "name":"neighbor",
    "desc":"totoro",
    "user_id":1,
    "cover":"http://s3.amazonaws.com/faetea-artcollection/collections/covers/000/000/001/original/1461623034.png?1461623034",
    "art_ids":[1,2,3,4,5,8,9,10,11,12,13]
  }
}
```

And then separate responses for each Art object

```json
{
  "art":
  {
    "id":1,
    "title":"sen",
    "caption":"chihiro",
    "collection_id":1,
    "image":"http://s3.amazonaws.com/faetea-artcollection/arts/images/000/000/001/original/1461623117.png?1461623117",
  }
}
```

## [License](LICENSE)

Source code distributed under the MIT license. Text and other assets copyright
General Assembly, Inc., all rights reserved.
