# README

## This is a URL shortner similar to bit.ly using Ruby on Rails (Ruby version 2.6.1, Rails version 5.2.3) and PostgreSQL version 11.

### To run this app locally you will need to have Ruby and PostgreSQL installed. If you need guidance getting your environment set up, there is a pretty great tutorial here: http://railsapps.github.io/installrubyonrails-mac.html

1. clone repo
2. bundle install
3. start up your rails server using `rails s`
4. open your server at localhost:3000

#### Shortening a URL
Make a request to http://localhost:3000/shorten + your params:

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
Make a request to http://localhost:3000/custom + your params:

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
Make a request to http://localhost:3000/stats + your params:

Here is an example request: http://localhost:3000/stats?slug=awesome-link

Your response should show you when the link was created, how many total visits there have been, and how many visits per day. It should look something like this:
```
{
  "created_at":"2019-04-12T20:16:02.166Z",
  "total_visits":1,
  "visits_per_day":{"2019-04-12 00:00:00 UTC":1}
}
```
