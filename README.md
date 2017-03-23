# Room crawler
Room Crawler System has core function is crawl rooms information form 2 sites “muabannhadat.vn” & “nhadat24h.net” and possible to extend more sites. 

The system helps people get huge collection of data about rooms which is selling or renting from some website. 

Technology used in project: 
+ Ruby on Rails, HTML5/CSS3, Boostrap 
+ [Mechanize](https://github.com/sparklemotion/mechanize) & [Nokogiri](https://github.com/sparklemotion/nokogiri) gem (lib) 
+ MongoDB 
+ Github for sub-version control 

## Getting started
Setup development environment:
+ [Ruby 2.4](https://www.ruby-lang.org/en/documentation/installation)
+ [Git 1.9](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
+ [Rails 5.0](https://gorails.com/setup/ubuntu/16.04)
+ [MongoDB 2.6](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu)

## Usage

### Setup local environment variable
Setup account basic authentication:
```ruby
#config/local_env.yml

BASIC_AUTHEN_USERNAME: username
BASIC_AUTHEN_PASSWORD: password 
```

### Crawling

Go to terminal, run below command:

```ruby
#crawl rooms from muabannhadat.vn
rake crawler:rooms:crawl_from_muabannhadat

#crawl rooms nhadat24h.net
rake crawler:rooms:crawl_from_nhadat24h
```

Check ```log/crawling_development.log``` for crawling log

### View
List room view: http://localhost:3000/rooms

Room detail view: http://localhost:3000/rooms/ [:room_id]

### Searching
Search room with any of 5 conditions:
+ provider site
+ code
+ city or distric or address
+ area
+ price
