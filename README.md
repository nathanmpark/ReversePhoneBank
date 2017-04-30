# Reverse Phone Bank

## (MyVoice)

This app represents the API component of the Reverse Phone Bank.

The dev server deployed @ https://rpb-dev-api.herokuapp.com

## EndPoints

Currently native clients can consume the following endpoints:

#### Users
* GET /users
* GET /users/:id
* POST /users (no auth)
* POST /authenticate

#### Reps
* POST /reps/search (no auth)
* POST /address_lookup (no auth)

#### Campaigns
* GET /campaigns
* GET /campaigns/:id
* GET /campaigns/:id/user_reps
* POST /campaigns
* PUT /campaigns
* PUT /campaigns/:id/:rep_uuid

User Attributes:
```ruby
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

## Authentication:

```bash
$ curl -H "Content-Type: application/json" -X POST -d '{"email":"tom@tom.com","password":"tomtom"}' http://rpb-dev-api.herokuapp.com/authenticate

```
Returns a payload like:
```bash
{"auth_token":"eyJ3eXAiOiJKV1QiLCJhbGciOiJIYzI1NiJ9.eyJ1c2VyX2lkLjoxLCJleHAiOjE0ODgyMiE0MzB9.CVqAjD1cii0HKwYbI3xgAMT3kfkiRhbRAXLs_n97rWU"}
```

#### Restricted Routes

Access any restricted page by sending the auth token you received at login as an Authorization header.

Auth token has a one week expiration.

```bash
curl -v -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1orizationOi eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTEyMzQxMzJ9.4I2IXLIu6TVsX2lmLf58oy5OGdd0i2BMExNZV22wSII" GET https://rpb-dev-api.herokuapp.com/users/1
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

## Rep Search
```POST /reps/search``` to find reps.

This route can accept the following attributes:

```ruby
user[level] # Defaults to 'national' for MVP purposes
user[office_type] # Currently can be one of 'house' or 'senate'
user[state]
user[county] # Not fully functional in MVP
user[party]
user[name] # Fuzzy type search so you could hit this endpoint on keyup or as a whole
```

A valid search will return a blob of relevant Rep data.

## Campaigns

#### Creation
```POST /campaigns``` to create the initial campaign object. Adding reps to a campaign is accomplished via a PUT after creation is complete.

This route can accept the following attributes:

```ruby
campaign[title]
campaign[description]
campaign[start_date]
campaign[end_date]
```

No user info is needed as it is assumed (for now) that the owner of a campaign is the authenticated current_user

A valid creation will return a new campaign object.

PUT functionality also exists for updating the objects initial values.

#### Adding Reps
```PUT /campaigns/:id/:rep_uuid```

This route accepts no additional attributes. Simply pass the UUID of a given rep.

Currently the flow is to make a separate PUT for each rep you wish to add to a given campaign.

A valid add will return the campaign blob with all associated reps.

Errors are rendered for duplicate rep additions as well as when no rep is found.

#### User Reps
```GET /campaigns/:id/user_reps```

This route accepts no additional attributes.

Route will return all reps associated with both the given campaign and the currently authenticated user.

### Contributing
PRs/Issues welcome.

A Google Civic API key is required to run the core process. Email a contributor
or go grab your own from the developer console. I keep my keys in a .env file. You do you boo.

* Clone this repo down
* cd into the project directory
* :> bundle
* :> rails db:setup
* :> rails s
