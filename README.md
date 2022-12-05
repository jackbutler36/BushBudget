# README

## Introduction ##

This application is an attandance management system developed for the bush school. The application's capabilities are divided into two different roles: Admins and Users
### Admins ###
When you are signed in as an admin, you have the ability to navigate between interfaces to interact with users, meetings and the admin dashboard. When you are in the Users interface,
you have the ability to create new users, delete or update existing users, and query through all of your registered users using the user master view. You can view the attendance history 
of any given user, which will show whether they attended, did not attend, or were excused from every meeting. Within the meetings interface, you have the ability to create new meetings, delete or update existing meetings,
and view the attendance roster for that meeting. In the admin dashboard you will see a bold notification regarding if any users have 3 or more unexcused absences, and you will be given a link to the list of those in bad
attendance standing (having missed 3+ meetings). There is also an interface called 'Admin Documentation' which gives useful information about setting up, maintaining and using this system. 
### Users ###
When you are signed is as a user, you have the ability to navigate between your user dashboard and your attendance history. The user dashboard will show if you have missed 2+ meetings, which is only one meeting away from
the admin being notified about your attendance standing. There's also an interface to view your own attandance history with respect to each meeting and whether or not you attended. to log attendance there is a form which asks 
for the user's UIN and the password of the meeting that the user is attending, which logs your attendance for that meeting and doesn't require the user to be signed in as a user or an admin. 

## Requirements ##

This code has been run and tested on:

* Ruby - 3.0.2
* Rails - 6.1.4
* Ruby Gems - Listed in `Gemfile`
* Docker Engine - 20.10.14 
* Docker container - 1.41 
* PostgreSQL - 13.3
* Yarn - 1.22.11


## External Deps  ##

* Docker - Download latest version at https://www.docker.com/products/docker-desktop
* Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
* Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

## Installation ##

Download this code repository by using git:

 `git clone https://github.com/jackbutler36/BushBudget.git`


## Tests ##

An RSpec test suite is available and can be ran using:

  `rspec spec/`

If this shows an error related to database migrations then try:

  `cd bin`

  `rails db:seed RAILS_ENV=test`

## Execute Code ##

Run the following code in Powershell if using windows or the terminal using Linux/Mac

  `cd your_github_here`

  `docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest`

  `cd rails_app`

Install the app

  `bundle install && rails webpacker:install && rails db:create && db:migrate`

Seed the database

  `rails db:seed`

Run the app
  `rails server --binding:0.0.0.0`

The application can be seen using a browser and navigating to http://localhost:3000/

## Environmental Variables/Files ##

As part of deployment on heroku one of the environment variables does need to be set in order for password recovery to work as expected.
To do this, navigate to the 'Settings' tab within the app after deploying it. Then create a new environment variable named `HEROKU_APP_NAME` and set
its value to be equal to the app name, stored in the 'App Information' section on the same page.
![alt text](/public/images/setting_app_name.JPG)
The application uses this environment variable to generate the link that points back to the app when a reset password email is sent. No other environment variables need to be set.

## Deployment ##

** Add instructions about how to deploy to Heroku

### Prerequisites ###
- Download heroku CLI (see above) and connect it to your heroku account via login.
- Create a heroku code pipeline associated with this repository.

### Deployment Instructions ###

1) In heroku CLI type in the command `heroku create --stack heroku-20 stage-test-app-1-<name>` where `<name>` is the name you want to give to the application. This creates an application in heroku, but it is not yet associated with a code pipeline.

2) From within your code pipeline, enter in the name of the new app in the staging section and click on it when it appears in the search results.

3) Click on the app and lick on the 'deploy' tab. in the automatic deployment section choose the branch you want the application to be build from (should be the 'main' branch). If you want you can also turn off automatic deployments and deploy it manually below.

4) Seed the data in the database. This is done by opening the app's console on heroku and entering rails db:seed. More detailed instructions are provided in the 'Admin Documentation' tab on the app, or in the PDF version provided if this is the first deployment of the application.

5) See the 'evironmental Variables/Files' section of this document to see how to set the environment variable needed for password recovery.

More details on how to manage the system or migrate the database between apps can be found in 'Admin Documentation' or in the offline PDF version.

## CI/CD ##

### CI ###
The continuous integration for this application is performed using github workflows located in `/.github/workflows/workflow.yml` in this directory.
The file starts off by defining environment variables needed for running the app in the test environment:

  `RUBY_VERSION: 3.0.2`: builds the image in ruby 3.0.2

  The remaining environment variables are used to initialize the database and user within the database for testing:
  `POSTGRES_USER: postgres`
  `POSTGRES_PASSWORD: password`
  `DATABASE_USER: postgres`
  `DATABASE_PASSWORD: password`

the workflow starts with the job named `Rails test`, which encapsulates everything. It specified the run the `rspec-test` job whenever there is a push or pull request done on the branch. This job is run on a virtual machine with the latest version of ubuntu run via github and uses the postgres database service on version 12, using the environment variables set earlier to create the database. The steps to the rspec-test job are as follows:
- `Install postgres client`: This installs the postgres client by running `sudo apt-get install libpq-dev`.
- `Install dependencies`: This installs all of the gems needed by running `gem install bundler` and `bundler install`.
- `Create database`: This creates the test environment postgresql database by running `bundler exec rails db:create RAILS_ENV=test` and `bundler exec rails db:migrate RAILS_ENV=test`. *important note: if you want to seed data straight into the database for testing then adding `bundler exec rails db:seed RAILS_ENV=test` should do so.
- `Run tests`: This runs all of the rspec tests (main purpose of CI) by running `bundler exec rspec .`. Ifany of them fail then github actions will show this as a failure and won't allow the branch to be merged with others until all failed cases are resolved.
- `Run brakeman`: This runs brakeman, our integrity/security vulnerability testing gem and outputs the results to a file called `brakeman.txt` by running `brakeman -o brakeman.txt`. An error or warning in this will also cause the github action to fail.
- `Run rubocop`: This runs rubocop, our code linter gem and outputs the results to a file called `rubocop.txt` by running `bundler exec rubocop --force-exclusion vendor/*/** --out rubocop.txt`. Rubocop warnings won't cause github actions to fail on their own, but they should be considered for future code maintainability.
- The remaining actions upload these reports along with the github action.

### CD ###
There are many ways to implement continous deployment. In the case of Heroku a code pipeline can be created that directly connects to this repository. Apps created within said pipeline can be built off of a specific branch that is within the code pipeline's repository and the app can be configured to deploy whenever a push or PR is made on a given branch, or deploying from a branch can be done manually instead of automatically as described before. More information can be found in the 'Admin Documentation' section of the application. See more details also at https://www.heroku.com/continuous-delivery.

## Support ##

Admins looking for support should first look at the 'Admin Documentation' page.
Users looking for help seek out assistance from the administrator.