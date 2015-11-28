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

###### User interface
Open on your browser

```
http://localhost:3000/account/authorizations
```

###### Admin interface
Open on your browser

```
http://localhost:3000/admin/users/1/authorizations
```

## Tests
```
$ bundle exec rspec
```
