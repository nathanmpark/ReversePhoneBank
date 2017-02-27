# Reverse Phone Bank
#### (Title pending)

This app represents the API component of the Reverse Phone Bank.

The server is currently deployed @ https://rpb-dev-api.herokuapp.com

### Usage

Currently native clients can consume the following endpoints:

* GET /users
* GET /users/:id
* POST /users
* POST /address_lookup

User Attributes:
```
user[first_name]
user[last_name]
user[email]
user[phone]
user[address][line_1]
user[address][line_2]
user[address][city]
user[address][state]
user[address][primary_zip]
user[address][extended_zip]
```

#### Logging In:

```bash
$ curl -H "Content-Type: application/json" -X POST -d '{"email":"tom@tom.com","password":"tomtom"}' http://localhost:3000/authenticate

```
Returns a payload like:
```bash
{"auth_token":"eyJ3eXAiOiJKV1QiLCJhbGciOiJIYzI1NiJ9.eyJ1c2VyX2lkLjoxLCJleHAiOjE0ODgyMiE0MzB9.CVqAjD1cii0HKwYbI3xgAMT3kfkiRhbRAXLs_n97rWU"}
```

#### Restricted Routes

Access any restricted page by sending the auth token you received at login as an Authorization header.

```bash
curl -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0ODgyMjk0MjR9WN0DZMNdc7ZlZLHG93eoD1NM" http://localhost:3000/users/1
```

Returns a Payload like:

```json
{
  "first_name": "Tom",
  "last_name": "TomTom",
  "email": "tom@tom.com",
  "phone": "(415) 555-0420",
  "created_at": "2017-01-29T01:43:52.370Z",
  "address": {
    "line_1": "1 W Portal Ave",
    "line_2": null,
    "city": "San Francisco",
    "state": "CA",
    "primary_zip": 94127,
    "extended_zip": null
  },
  "reps": [
    {
      "name": "Mike Pence",
      "party": "Republican",
      "email": null,
      "img_url": null,
      "address_string": "The White House 1600 Pennsylvania Avenue NW Washington, DC 20500",
      "public_office": "Vice-President of the United States",
      "public_office_id": "ocd-division/country:us",
      "phone_numbers": [
        "(202) 456-1111"
      ],
      "urls": [
        "http://www.whitehouse.gov/"
      ],
      "channels": {
        "GooglePlus": "+whitehouse",
        "Facebook": "whitehouse",
        "Twitter": "whitehouse"
      }
    },
    {
      "name": "Donald J. Trump",
      "party": "Republican",
      "email": null,
      "img_url": null,
      "address_string": "The White House 1600 Pennsylvania Avenue NW Washington, DC 20500",
      "public_office": "President of the United States",
      "public_office_id": "ocd-division/country:us",
      "phone_numbers": [
        "(202) 456-1111"
      ],
      "urls": [
        "http://www.whitehouse.gov/"
      ],
      "channels": {
        "GooglePlus": "+whitehouse",
        "Facebook": "whitehouse",
        "Twitter": "whitehouse"
      }
    }
  ]
}
```

#### Lookup Reps for a non registered user

Note: An address must have at a minimum, a line_1 and a primary_zip attribute. Also this route utilizes a dummy user with email 'sample@sample.com' to make the rep relations valid.

```bash
curl -d 'address[line_1]=242%20Molimo%20Drive&address[primary_zip]=94127' http://localhost:3000/address_lookup
```

Returns a payload like:
```json
[
  {
    "id": 43,
    "name": "Greg Abbott",
    "party": "Republican",
    "email": null,
    "img_url": "http://gov.texas.gov/multimedia/photos/2015-GovernorAbbott-Portrait.jpg",
    "address_string": "P.O. Box 12428 Austin, TX 78711",
    "public_office": "Governor",
    "public_office_id": "ocd-division/country:us/state:tx",
    "uuid": "263e6e7a-0a52-48be-9e02-657b25e76b5f",
    "phone_numbers": [
      "(512) 463-2000"
    ],
    "urls": [
      "http://www.governor.state.tx.us/"
    ],
    "channels": {
      "GooglePlus": "114575192028324795215",
      "Facebook": "TexasGovernor",
      "Twitter": "TexGov"
    }
  },
  {
    "id": 1,
    "name": "Donald J. Trump",
    "party": "Republican",
    "email": null,
    "img_url": "https://www.whitehouse.gov/sites/whitehouse.gov/files/images/45/PE%20Color.jpg",
    "address_string": "The White House 1600 Pennsylvania Avenue NW Washington, DC 20500",
    "public_office": "President of the United States",
    "public_office_id": "ocd-division/country:us",
    "uuid": "ab638d15-0caf-4abc-a8d2-bb95a581ce74",
    "phone_numbers": [
      "(202) 456-1111"
    ],
    "urls": [
      "http://www.whitehouse.gov/"
    ],
    "channels": {
      "GooglePlus": "+whitehouse",
      "Facebook": "whitehouse",
      "Twitter": "whitehouse",
      "YouTube": "whitehouse"
    }
  },
  {
    "id": 2,
    "name": "Mike Pence",
    "party": "Republican",
    "email": null,
    "img_url": "https://www.whitehouse.gov/sites/whitehouse.gov/files/images/45/VPE%20Color.jpg",
    "address_string": "The White House 1600 Pennsylvania Avenue NW Washington, DC 20500",
    "public_office": "Vice-President of the United States",
    "public_office_id": "ocd-division/country:us",
    "uuid": "955044a8-bbbd-41bc-9ca6-ec7832fc7297",
    "phone_numbers": [
      "(202) 456-1111"
    ],
    "urls": [
      "http://www.whitehouse.gov/"
    ],
    "channels": {
      "GooglePlus": "+whitehouse",
      "Facebook": "whitehouse",
      "Twitter": "whitehouse"
    }
  }
]
```

#### Registering a new User

```bash
curl -d 'user[first_name]=Bugs&user[last_name]=Bunny&user[email]=bugs@bunny.com&user[phone]=(342)%20555-5578&user[password]=tomtom&user[password_confirmation]=tomtom&user[address][line_1]=4850%20SW%20Snow%20Cir&user[address][city]=Holt&user[address][state]=MO&user[address][primary_zip]=64048' http://localhost:3000/users
```

Valid User returns User show

### Contributing
PRs/Issues welcome.

A Google Civic API key is required to run the core process. Email a contributor
or go grab your own from the developer console. I keep my keys in a .env file. You do you boo.

* Clone this repo down
* cd into the project directory
* :> bundle
* :> rails db:setup
* :> rails s
