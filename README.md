# README

This is a URL shortner API similar to bit.ly using Ruby on Rails (Ruby version 2.6.1, Rails version 5.2.3) and PostgreSQL version 11.

This API can be viewed in a production environment at the base URL https://short-url-kingan.herokuapp.com/ + the endpoint of your choosing. 

Example https://short-url-kingan.herokuapp.com/shorten?body=https://range.co

The endpoints include: 
* `/shorten` for getting a shortened URL
* `/custom` for getting a custom URL
* `/stats` for getting stats about your URL
* `/{your-short-url}` for visiting your short URL



#### Setup

To run this app locally you will need to have Ruby and PostgreSQL installed. If you need guidance getting your environment set up, there is a great tutorial here: http://railsapps.github.io/installrubyonrails-mac.html

1. clone repo
2. bundle install
3. start up your rails server using `rails s`
4. open your server at localhost:3000

#### Shortening a URL
Make a request to http://localhost:3000/shorten + your params using the `body` key:

Here is an example request: http://localhost:3000/shorten?body=https://range.co/

Your response should look like this: 
```
{ 
  "success":true,
  "original_link":"https://range.co/",
  "slug":"jVL3goRB",
  "full_link":"http://localhost:3000/jVL3goRB"
}
```

#### Creating a custom URL
Make a request to http://localhost:3000/custom + your params using the `body` and `slug` keys:

Here is an example request: http://localhost:3000/custom?body=https://range.co/&slug=awesome-link

Your response should look like this:
```
{
  "success":true,
  "original_link":"https://range.co/",
  "slug":"awesome-link",
  "full_link":"http://localhost:3000/awesome-link"
}
```

#### Visiting your shortened link will redirect you to your original link
Visit your new shortened link http://localhost:3000/awesome-link and you should be redirected to your original link https://range.co/

The API will also record your visit.

#### Seeing the number of visits and statistics about your link
Make a request to http://localhost:3000/stats + your params using the `slug` key:

Here is an example request: http://localhost:3000/stats?slug=awesome-link

Your response should show you when the link was created, how many total visits there have been, and how many visits per day. It should look something like this:
```
{
  "created_at":"2019-04-12T20:16:02.166Z",
  "total_visits":1,
  "visits_per_day":{"2019-04-12 00:00:00 UTC":1}
}
```

#### Running tests

To run the full test suite simply type the command `rspec` in your CLI.

#### Still more todo:
If I spent more time on this I would focus on:
1. better error handling
2. more tests
3. better validations (ie uniqueness)
4. creating a nice UI to interact with the API
5. I would have the stats endpoint use the `full_link` attribute for reasons of uniqueness

