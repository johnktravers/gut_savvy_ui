# README

**Description:**


Gut Savvy is an application for tracking the foods that you eat, giving your meals a rating based on how you feel, and receiving results that will help you determine which foods are good and which foods are bad for your gut health.

Gut Savvy was built using: Ruby version 2.4.1, Rails version 5.2.4, Sinatra, and JavaScript.


**Local Setup:**


Visit https://github.com/johnktravers/gut_savvy_ui and clone down the repo. Once you have cloned Gut Savvy onto your local computer, open a text editor like Atom, and bundle to add the gemfile to your system. This will enable you to work on the user interface side of the application. 


Gut Savvy also utilized a microservice setup using Sinatra. Visit https://github.com/Jonpatt92/gut_savvy_service to clone down and install the service. This microservice hits the FDC API. This service accepts a 12-digit UPC code and returns information of the related food product. 


**How to Use:**


To use this application you must log a meal. In our system a meal can consist of many dishes and a dish can be made up of many foods. To add a meal you must visit your profile dashboard. From this page you should click the 'Log A Meal' button and then you will be taken to the Log a Meal page. From this page, click 'Add a New Dish' and then from the dish page you can add the specific foods you ate in that dish.


After you have created a meal you will need to add your Gut Feeling in order to have results. A Gut Feeling is our numeric rating system for how you feel after eating a meal. This system goes from 5 to -5. A rating of 5 means you are feeling the best, a rating of 0 means you are feeling neutral, and a rating of -5 means you are feeling the worst. Your initial Gut Feeling must be applied to a meal within 72 hours of adding the meal to our application. This rating is able to be edited for 24 hours, at which point the Gut Feeling will be permanently saved in the system.


The purpose of your results page is to help you keep track of what foods and ingredients are making you feel good and also which are making you feel bad. The results page will have several graphs and charts with information based on your Gut Feelings. You will need to add a Gut Feeling to 12 meals before your results page is populated with information.


**Roadmap:**


Our goal is to add an advanced analysis feature for food ingredients that will help better define what foods we recommend the user eat and which we recommend they avoid. Our goal is to be very precise in our food results and recommendations. 


**Project Status:**


This project was created as a school project, but continued support and functionality if planned. Current status is functional but in an early stage of the overall plan for this application. 


**Authors:**


Christopher Kelling, John Travers, Jonathan Patterson, Ryan Hantak


**Support:**


All of the authors of this program have a presence on GitHub. Read out there for help or support for this program.


