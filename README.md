# Odinbook

This is a facebook clone app that is the [final project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/final-project) of [The Odin Project's](https://www.theodinproject.com/) [Rails course](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails).

## Features

Users have the ability to register traditionally or with facebook.  Once a user registers, they are sent a welcome email and are prompted to create a profile that contains basic information.  They also have the option to upload a profile picture.  Users can create posts with either text or an image (or both).  Posts can be commented on and liked.  Users can send friend requests to other users.  Users can either accept or ignore friend requests.  An accepted friend request results in a friendship between two users.  Users can also 'unfriend' their friends.  Users will receive notifications when they register, when they receive friend requests, and when their posts are either commented on or liked.  

## Testing

The app was built using a test driven development (TDD) approach.  Feature specs were written to cover all the features of the app that a user could see or interact with (all the permitted functionality).  Controller specs were written to test user authentication and authorization (all the non-permitted functionality).  Model specs were written to test Active Record models at the unit level.  Testing tools employed include RSpec, Capybara, FactoryBot, Database Cleaner, and Simplecov.  By the time development was completed, test coverage was at 99% (as determined by Simplecov) and all tests were passing.    

A significant amount of time was invested in learning how to test web apps in general.  On previous projects I had experience using RSpec to write unit and integration tests (see the [Chess app](https://github.com/esteban90-dev/Chess) I made), but there was a steep learning curve in determining which types of tests to write for a web application.  Testing was by far the hardest part of creating this app.  Here are the main resources that helped guide me through this process: 

1. Jason Swett's [integration testing guide](https://www.codewithjason.com/rails-integration-tests-rspec-capybara/)
2. Thoughtbot's [Testing Rails book](https://books.thoughtbot.com/assets/testing-rails.pdf)
3. Aaron Sumner's [Everyday Rails Testing with RSpec](https://leanpub.com/everydayrailsrspec)

As difficult as it was to learn all the different layers of testing, it was wonderful having full test coverage when writing new features to ensure that there weren't any regressions with existing features. 

## Deployment

The app was deployed with Heroku.  The database was seeded with random users.  A live version of the app can be found [here.](https://serene-brook-76128.herokuapp.com/)