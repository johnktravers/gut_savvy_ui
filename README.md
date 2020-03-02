# Gut Savvy

## Introduction

Have you ever had an upset stomach from something that you ate, but not known exactly what that was? Gut Savvy is an application that helps users track what they eat and how they feel after eating to learn which ingredients in the foods they eat are good for their digestive system, and which are harmful.


## Initial Setup

Navigate into your desired directory and execute the following commands to set up the repository locally:

```
git clone git@github.com:johnktravers/gut_savvy_ui.git gut_savvy
cd gut_savvy
bundle install
rake db:{create,migrate,seed}
rails server
```

Once the commands have finished executing, open a web browser and navigate to http://localhost:3000. You can now access the application locally.


## Running Tests

To make sure the repository is set up correctly, run the test suite with the following command:

```
bundle exec rspec
```


## How to Use

The user is first greeted by the splash page, where they can find a section on how to use the app and click the sign in button to sign in using Google OAuth2.

<img width="1440" alt="gut_savvy_splash_page" src="https://user-images.githubusercontent.com/46035439/75641991-386def80-5bf7-11ea-91b3-2e12ee094b0f.png">

Upon signing in, the user is directed to their dashboard, where they can log a new meal. Meals are composed of multiple dishes (groups of foods that are commonly eaten together), and dishes are made of multiple foods.

The user can scan product barcodes or manually enter 12-digit UPC codes to add foods to a dish, or select from previously eaten dishes. The user can then add multiple dishes to the new meal.

<img width="1439" alt="gut_savvy_barcode_scanning" src="https://user-images.githubusercontent.com/46035439/75642001-428fee00-5bf7-11ea-8f68-1db882943c16.png">

After logging the new meal, the user is prompted to enter a "Gut Feeling", or digestive rating, for that meal. The scale ranges from -5 to 5, with -5 being the worst digestive experience ever and 5 being the best. After 12 meals are logged in the system and rated, the user can see their results.

The results page consists of graphs of the best and worst ingredients found in the foods that the user has eaten based on their rating across every meal logged.  It also has a Gut Feeling Timeline, so the user can track their progress to improving digestion, and a table of every ingredient eaten along with the foods it is contained in.

<img width="1440" alt="gut_savvy_results" src="https://user-images.githubusercontent.com/46035439/75641999-40c62a80-5bf7-11ea-82ec-37113a025f10.png">


## Database Schema

<img width="1111" alt="gut_savvy_schema" src="https://user-images.githubusercontent.com/46035439/75641340-2ee38800-5bf5-11ea-9e26-6fa6993364f0.png">


## Tech Stack

- Ruby on Rails
- JavaScript
  - Quagga.js -> barcode scanning
  - Morris.js -> results page graphs
- JQuery
- Sinatra -> [microservice](https://github.com/Jonpatt92/gut_savvy_service)
- PostgreSQL
- RSpec
- Travis CI


## How to Contribute

If you would like to make a contribution, please fork the repo and set it up locally using the instructions above. Commit your changes, make a PR to this repo, and we'll get to it shortly. If you have any questions or advice for new features, feel free to reach out to any of the core contributors below.


## Core Contributors

- [Christopher Kelling](https://github.com/cjkelling)
- [John Travers](https://github.com/johnktravers)
- [Jonathan Patterson](https://github.com/jonpatt92)
- [Ryan Hantak](https://github.com/rhantak)
