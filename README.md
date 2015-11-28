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

## How to contribute


###Adding plugins

The plugins are stored in the lib/plugins directory. Every plugin should have a class method `change_password` that is used to change the password of the related credential.

After adding the plugin you need to create a `Credential` record in order to store the username and the password that is going to be used to login and ultimately change the password.

**Important**: This credential should have a name that matches with the class name of the plugin. 

i.e:

If you're adding a Twitter plugin, if the plugin class is `Plugins::Twitter` then the name of the `Credential should be "twitter", that way we're able to infer what class is responsible of handling the password change from the credential name.

