# Flypass

Corporate password manager that automatically changes passwords for services.

## Requirements
 - Ruby 2.2.2p95
 - bundle gem

## Setup
```
$ bundle install
```

## Usage

The app has two interfaces

```
$ script/server
```

###### Admin interface
Open on your browser

```
http://localhost:3000/users/1/authorizations
```

###### User interface
Open on your browser

```
http://localhost:3000/account/authorizations
```


## Tests
```
$ bundle exec rspec
```
