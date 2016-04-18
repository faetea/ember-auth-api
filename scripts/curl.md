# CURL documentation

`chmod 755 *.sh` to make scripts runable

## Successes

I checked that all the pre-written Authentication scripts worked:

-   curl to sign-up and sign-in worked
-   curl to change-password and sign-out worked
-   curl to GET all users worked [index]
-   curl to GET specific user by id worked [show]

I began writing New Scripts:

-   curl to update specific user by id worked
-   curl to create new collection worked, user_id present!
-   curl to index and show all collections or one collection by id worked
-   curl to update and destroy specific collection worked! user can only alter records created by themselves!

## To Do List

-   GET /arts index
-   POST /arts create
-   GET /arts/:id show
-   PATCH /arts/:id update
-   DELETE /arts/:id destroy

### POST /sign-up

scripts/sign-up.sh

```json
{
  "user":
  {
    "id":1,
    "email":"moon@rabbit",
    "username":null,
    "first_name":null,
    "last_name":null,
    "bio":null,
    "image":null
  }
}
```

### POST /sign-in

scripts/sign-in.sh

```json
{
  "user":
  {
    "id":1,
    "email":"moon@rabbit",
    "token":"BAhJIiVkOTQ3OTA5MGNkN2MzZjNiMDdkNDgxZjUzYjIxMTE0MQY6BkVG--b8db321a1619f5cc9e8b69d5dadc06e2923b3599"
  }
}
```

### PATCH /change-password/:id

ID=1 TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/change-password.sh

### DELETE /sign-out/:id

ID=1 TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/sign-out.sh

### GET /users

TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/users.sh

```json
{
  "users":
  [
    {
      "id":1,
      "email":"star@hub",
      "username":null,
      "first_name":null,
      "last_name":null,
      "bio":null,
      "image":null
    },
    {
      "id":3,
      "email":"carrot@hub",
      "username":null,
      "first_name":null,
      "last_name":null,
      "bio":null,
      "image":null
    },
    {
      "id":2,
      "email":"moon@hub",
      "username":null,
      "first_name":null,
      "last_name":null,
      "bio":null,
      "image":null
    }
  ]
}
```

### GET /users/:id

ID=2 TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/user.sh

```json
{
  "user":
  {
    "id": 3,
    "email": "star@fire",
    "username": "st4rFir3",
    "first_name": "Colleen",
    "last_name": "Sharp",
    "bio": "Colleen Graduated from University with a Bachelor in musical composition, bassoon performance and music.  Begain a Masters degree at University of Hawaii in Manoa studying Ethnomusicology and then transfered to Tokyo University of Fine Arts to continue her research in Japanese music, nagauta shamisen and gagaku shou.  Her goal is to write original compositions with the hope to educate and spread the knowledge of the unique music being created today in Japan.",
    "image":null
  }
}
```

```json
{
  "user": {
    "id":4,
    "email":"moon@rabbit",
    "username":"tsukihime",
    "first_name":"Usagi",
    "last_name":"Tsukino",
    "bio":"Usagi Tsukino is a lifelong artist, maker, and educator.  Her passions include sewing, woodworking, photography, and oil painting.  Usagi is an instructor in woodworking and sewing at one of the largest maker spaces in the country.  Her teaching experience spans 11 years and over 10 different media.  She currently offers private lessons in sewing, woodworking, drawing, and painting.",
    "image":null
  }
}
```

### PATCH /user/:id

First I went through rails console instead of CURL:

```ruby
u = User.find(3)
u.authenticate("ball")
u.update_attributes(username: "st4rFir3", first_name: "Colleen", last_name: "Sharp", bio: "Colleen Graduated from University with a Bachelor in musical composition, bassoon performance and music.  Begain a Masters degree at University of Hawaii in Manoa studying Ethnomusicology and then transfered to Tokyo University of Fine Arts to continue her research in Japanese music, nagauta shamisen and gagaku shou.  Her goal is to write original compositions with the hope to educate and spread the knowledge of the unique music being created today in Japan.")
```

ID=1 TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/user-update.sh

```sh
--data '{
  "user": {
    "username": "st4rFir3",
    "first_name": "Chris",
    "last_name": "Sharp",
    "bio": "Colleen Graduated from University with a Bachelor in musical composition, bassoon performance and music.  Begain a Masters degree at University of Hawaii in Manoa studying Ethnomusicology and then transfered to Tokyo University of Fine Arts to continue her research in Japanese music, nagauta shamisen and gagaku shou.  Her goal is to write original compositions with the hope to educate and spread the knowledge of the unique music being created today in Japan."
  }
}'
```

```json
{
  "user":
  {
    "id":4,
    "email":"moon@rabbit",
    "username":"tsukihime",
    "first_name":"Bunny",
    "last_name":"Ellis",
    "bio":"Bunny Ellis is a lifelong artist, maker, and educator.  Her passions include sewing, woodworking, photography, and oil painting.  Bunny is an instructor in woodworking and sewing at one of the largest maker spaces in the country.  Her teaching experience spans 11 years and over 10 different media.  She currently offers private lessons in sewing, woodworking, drawing, and painting.",
    "image":null
  }
}
```

SELECT id, email, username, first_name, last_name, updated_at FROM users;


### POST /collections

TOKEN=4c102bc828791064131936b09268aafa scripts/collection-create.sh

```json
{
  "collection":
  {
    "id":1,
    "name":"First Collection",
    "desc":"Creating a collection through a curl request.",
    "image":null
  }
}
```

### GET /collections

scripts/collections.sh

```json
{
  "collections":
  [
    {
      "id":1,
      "name":"First collection",
      "desc":"I will fill you with photos!!!",
      "image":null
    },
    {
      "id":2,
      "name":"2nd collection",
      "desc":"just drawings of dragons in here forever.",
      "image":null
    },
    {
      "id":3,
      "name":"Watchman Journal",
      "desc":"Photos of interesting things witnessed around Ankh-Morpork",
      "image":null
    },
    {
      "id":4,
      "name":"Dwaven Bread",
      "desc":"historical artifacts and my childhood.",
      "image":null
    },
    {
      "id":5,
      "name":"Shamisen",
      "desc":"My instruments, performances, students and instructors",
      "image":null
    },
    {
      "id":6,
      "name":"Japanese Gardens",
      "desc":"all of the different public gardens I have visited",
      "image":null
    }
  ]
}
```

### GET /collections/:id

ID=2 scripts/collection.sh

```json
{
  "collection":
  {
    "id":2,
    "name":"Second Collection of User One",
    "desc":"This will contain a group of photos or drawings!",
    "image":null
  }
}
```

### PATCH /collections/:id

ID=1 TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/collection-update.sh

```json
{
  "collection":
  {
    "id":1,
    "name":"Pretty Things",
    "desc":"There be images in here!",
    "image":null
  }
}
```

### DELETE /collections/:id

ID=1 TOKEN=33ad6372f795694b333ec5f329ebeaaa scripts/collection-delete.sh
