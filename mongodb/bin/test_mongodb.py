# References:
# https://api.mongodb.com/python/current/tutorial.html
# https://api.mongodb.com/python/current/examples/authentication.html
# https://docs.mongodb.com/manual/reference/operator/

import datetime
import pprint
import urllib.parse

import pymongo
from pymongo import MongoClient
from bson.objectid import ObjectId


host = 'kai-mongodb'  # ip or server name
port = 27017
username = 'user1'
password = 'user1Pass'
authSource = 'mydb'
authMechanism = 'SCRAM-SHA-256'

## Making a Connection with MongoClient
# method 1
# client = MongoClient(host=host, port=port,
#                      username=username, password=password,
#                      authSource=authSource, authMechanism=authMechanism)

# method 2
uri = f"mongodb://{username}:{password}@{host}:{port}/?authSource={authSource}&authMechanism={authMechanism}"
client = MongoClient(uri)


## Getting a Database and collection
db = client['mydb']  
collection = db['test_collection']

# Attribute style access won’t work (like test-database)
# db = client.mydb
# collection = db.test


## Documents
post = {"author": "Mike",
        "text": "My first blog post!",
        "tags": ["mongodb", "python", "pymongo"],
        "date": datetime.datetime.utcnow()}


## Insert a Document
posts = db.posts
post_id = posts.insert_one(post).inserted_id
print(repr(post_id))

# list all of the collections in our database
db.list_collection_names()


## Getting a Single Document With find_one()
# The returned document contains an "_id", which was automatically added on insert.
pprint.pprint(posts.find_one())

# Querying By author
pprint.pprint(posts.find_one({"author": "Mike"}))
# No author value named Eliot, so returns None
print(posts.find_one({"author": "Eliot"}))

# Querying By ObjectId
pprint.pprint(posts.find_one({"_id": post_id}))
# The type of post_id is ObjectId
# Note that an ObjectId is not the same as its string representation:
post_id_as_str = str(post_id)
print(posts.find_one({"_id": post_id_as_str})) # No result

# The web framework gets post_id from the URL and passes it as a string
def get(post_id):
    # Convert from string to ObjectId:
    document = client.db.collection.find_one({'_id': ObjectId(post_id)})


## Bulk Inserts
# new_posts[1] has a different “shape” than the other posts
new_posts = [{"author": "Mike",
              "text": "Another post!",
              "tags": ["bulk", "insert"],
              "date": datetime.datetime(2009, 11, 12, 11, 14)},
             {"author": "Eliot",
              "title": "MongoDB is fun",
              "text": "and pretty easy too!",
              "date": datetime.datetime(2009, 11, 10, 10, 45)}]
result = posts.insert_many(new_posts)
# The result from insert_many() now returns two ObjectId instances, one for each inserted document.
print(result.inserted_ids)

## Querying for More Than One Document
# find() returns a Cursor instance,
# which allows us to iterate over all matching documents.
for post in posts.find():
    pprint.pprint(post)
# limit the returned results
for post in posts.find({"author": "Mike"}):
    pprint.pprint(post)


## Counting
# We can get a count of all of the documents in a collection:
posts.count_documents({})
# or just of those documents that match a specific query:
posts.count_documents({"author": "Mike"})


## Range Queries
# date less than 2019/11/12 12:00
d = datetime.datetime(2009, 11, 12, 12)
for post in posts.find({"date": {"$lt": d}}).sort("author"):
    pprint.pprint(post)
# dates between 2019/11/1 00:00 ~2019/11/11 00:00 
date_1 = datetime.datetime(2009, 11, 1, 0)
date_2 = datetime.datetime(2009, 11, 11, 0)
cursor = posts.find({"$and": [{"date": {"$gt": date_1}},
                              {"date": {"$lt": date_2}}]}).sort("author")
for post in cursor:
    pprint.pprint(post)


# Indexing
# Adding indexes can help accelerate certain queries and
# can also add additional functionality to querying and storing documents.
result = db.profiles.create_index([('user_id', pymongo.ASCENDING)],
                                  unique=True)
db.list_collection_names()

user_profiles = [
    {'user_id': 211, 'name': 'Luke'},
    {'user_id': 212, 'name': 'Ziltoid'}
]
result = db.profiles.insert_many(user_profiles)
# The index prevents us from inserting a document whose 
# user_id is already in the collection:
new_profile = {'user_id': 213, 'name': 'Drew'}
duplicate_profile = {'user_id': 212, 'name': 'Tommy'}
result = db.profiles.insert_one(new_profile)  # This is fine.
# result = db.profiles.insert_one(duplicate_profile)  # raise an DuplicateKeyError

for profile in  db.profiles.find():
    pprint.pprint(profile)

# client.close()
