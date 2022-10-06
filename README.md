# Xometry HttpClient

Task description:
- Connect to the remote API with generated an access token.
- Download the report, pars it and print (io / screen) in format: 'URL - UNIQ CONNECTIONS COUNT' (ex: '/home - 13')

## Run

* Install Ruby version 2.7.2: `rvm install 2.7.2`
* Bundle: `bundle install`
* Set XOM_KEY: `export XOM_KEY=key`
* Run: `bundle exec ruby main.rb`
* Response example:
```
=====================
Response code: 200
=====================
/contacts - 19
/home - 14
/contact-us - 16
/about - 12
/news - 16
/blog - 13
/products - 10
```
