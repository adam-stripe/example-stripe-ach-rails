# A Stripe ACH example app

An example app illustrating accepting ACH donations with [Stripe](https://stripe.com). Find more about this in [Stripe's ACH documentation](https://stripe.com/docs/ach).

## Demo
You can find a demo of this application running at [https://stripe-ach-example-app.herokuapp.com/](https://stripe-ach-example-app.herokuapp.com/). 

There are test credentials for Plaid [available in their docs](https://plaid.com/docs/api/#sandbox) and you can find test routing and account numbers for manual bank account entry in [Stripe's ACH docs](https://stripe.com/docs/ach#testing-ach).

## Features

* Authenticate bank accounts with [Plaid Link](https://plaid.com/integrations/stripe/). 
* Accept [manual entry of bank account details](https://stripe.com/docs/ach#manually-collecting-and-verifying-bank-accounts) and microdeposit verification. 
* Create [ACH charges](https://stripe.com/docs/ach#creating-an-ach-charge) for an amount the customer selects.
* View all payments made by the current customer using the [list charges method](https://stripe.com/docs/api#list_charges).

## Other notes

* This example just stores a customer ID in a session, but IRL you'll probably want to store this in your database.
* JavaScript is inlined for easier readability if you're not familiar with navigating Rails and the asset pipeline.