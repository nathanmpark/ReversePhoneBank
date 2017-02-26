# Reverse Phone Bank
#### (Title pending)

This app represents the API component of the Reverse Phone Bank.

### Usage

Currently native clients can consume the following endpoints:

* GET /users
* GET /users/:id
* POST /users

POST Attributes:
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


Sample POST:
```
https://rpb-dev-api.herokuapp.com/users?user[first_name]=Bugs&user[last_name]=Life&user[email]=bugs@example.com&user[phone]=(415) 689-5233&user[address][line_1]=2178 S.W. CR 534&user[address][city]=Mayo&user[address][state]=FL&user[address][primary_zip]=32066
```

The server is currently deployed @ https://rpb-dev-api.herokuapp.com

### Authorization

#### Logging In:

```bash
$ curl -H "Content-Type: application/json" -X POST -d '{"email":"tom@tom.com","password":"tomtom"}' http://localhost:3000/authenticate

```
Returns a payload like:
```bash
{"auth_token":"eyJ3eXAiOiJKV1QiLCJhbGciOiJIYzI1NiJ9.eyJ1c2VyX2lkLjoxLCJleHAiOjE0ODgyMiE0MzB9.CVqAjD1cii0HKwYbI3xgAMT3kfkiRhbRAXLs_n97rWU"}
```

#### Navigation

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
    },
    {
      "name": "Jackie Speier",
      "party": "Democratic",
      "email": null,
      "img_url": "https://speier.house.gov/sites/speier.house.gov/files/documents/gray%20jacket%20KB%20retouch.jpg",
      "address_string": "211 Cannon House Office Building Washington, DC 20515",
      "public_office": "United States House of Representatives CA-14",
      "public_office_id": "ocd-division/country:us/state:ca/cd:14",
      "phone_numbers": [
        "(202) 225-3531"
      ],
      "urls": [
        "http://speier.house.gov/"
      ],
      "channels": {
        "Facebook": "JackieSpeier",
        "Twitter": "RepSpeier",
        "YouTube": "JackieSpeierCA14"
      }
    }
  ]
}
```
### Contributing
PRs/Issues welcome.

A Google Civic API key is required to run the core process. Email a contributor
or go grab your own from the developer console. I keep my keys in a .env file. You do you boo.

* Clone this repo down
* cd into the project directory
* :> bundle
* :> rails db:setup
* :> rails s
