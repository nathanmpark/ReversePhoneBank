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

### Contributing
PRs/Issues welcome.

A Google Civic API key is required to run the core process. Email a contributor
or go grab your own from the developer console. I keep my keys in a .env file. You do you boo.

* Clone this repo down
* cd into the project directory
* :> bundle
* :> rails db:setup
* :> rails s
