const express = require('express');
const app = express();
const jwt = require('jsonwebtoken');

const MongoClient = require('mongodb').MongoClient;
const ObjectId = require('mongodb').ObjectID;

// Connection URL
const url = 'mongodb://127.0.0.1:27017';

// Database Name
const dbName = 'swift_server';

// shared secret
const sharedSecret = "hi-there_i'm-a_sharedSecret";

app.use(express.json());

function verifyToken(req, res, next) {
    let token = req.headers.token || req.query.token || null;
    jwt.verify(token, sharedSecret, function(err, decoded) {
        if (err) {
            return res.status(401).json({
                error: err.message,
            }).end();
        }
        req.user = decoded;
        next();
    });
}

// Use connect method to connect to the server
MongoClient.connect(url, function(err, client) {
    console.log("Connected successfully to server");
    const db = client.db(dbName);

    // no auth at all
    app.get('/checkhand', (req, res) => res.json({
        key: "Server Loves You!"
    }));

    // all users with auth
    app.get('/user', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }
        const collection = db.collection('users');
        collection.find({}, {
            projection: {
                password: 0
            }
        }).toArray(function(err, docs){
            if (err) {
                throw err;
            }
            if (!docs.length) {
                return res.status(402).json({
                    error: "no users found"
                }).end();
            }

            return res.json(docs).end();
        });
    });

    // login without auth
    app.post('/auth/token', (req, res) => {
        // check if the user into our DB
        const collection = db.collection('users');
        collection.find({
            email: req.body.email,
            password: req.body.password
        }).toArray(function(err, docs) {
            if (err) {
                throw err;
            }
            if (!docs.length) {
                return res.status(401).json({
                    error: "user or password didn't match"
                }).end();
            }
            const token = jwt.sign(docs[0], sharedSecret);

            return res.json({
                token,
                user: docs[0]
            }).end();
        });
    });

    // update user with auth
    app.put('/user/update', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }
        // prepare user object
        const user = {
            name: req.body.name,
            email: req.body.email
        }

        if (req.body.password) {
            user['password'] = req.body.password;
        }

        const collection = db.collection('users');

        // Update document
        collection.updateOne({
            _id: ObjectId(req.body._id)
        }, {
            $set: user
        }, (err, result) => {
            if (err) {
                throw err;
            }
            if (result.result.nModified > 0) {
                delete req.body.password;
                return res.json(req.body).end();
            }

            return res.json(result.result).end();
        });
    });

    // delete user with auth
    app.put('/user/delete/:id', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }

        const collection = db.collection('users');
        // delete document
        collection.deleteOne({
            _id: ObjectId(req.params.id)
        }, (err, result) => {
            if (err) {
                throw err;
            }

            return res.json(result.result).end();
        });
    });

    // create new user with auth
    app.post('/user/new', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }
        const collection = db.collection('users');
        // Insert some documents
        collection.insertOne(req.body, (err, result) => {
            if (err) {
                throw err;
            }
            return res.json(result).end();
        });
    });

    app.get('/light', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }
        const collection = db.collection('light');
        collection.find({}).toArray(function(err, docs){
            if (err) {
                throw err;
            }
            if (!docs.length) {
                return res.status(402).json({
                    error: "no points found"
                }).end();
            }

            return res.json(docs).end();
        });
    });

    // create point with auth
    app.post('/light/create', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }
        const collection = db.collection('light');
        // Insert some documents
        collection.insertOne(req.body, (err, result) => {
            if (err) {
                throw err;
            }
            return res.json(result).end();
        });
    });

    // update point with auth
    app.get('/light/toggle/:id', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }
        const collection = db.collection('light');
        // find document
        collection.findOne({
            _id: ObjectId(req.params.id)
        }).then((point) => {
            // Update documents
            collection.updateOne({
                _id: ObjectId(req.params.id)
            }, {
                $set: {
                    status: !point.status
                }
            }, (err, result) => {
                if (err) {
                    throw err;
                }
                setTimeout(function(){
                    return res.json(result).end();
                }, 2000);
            });
        })
    });

    app.get('/room', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }
        const collection = db.collection('room');
        collection.find({}).toArray(function(err, docs){
            if (err) {
                throw err;
            }
            if (!docs.length) {
                return res.status(402).json({
                    error: "no rooms found"
                }).end();
            }

            return res.json(docs).end();
        });
    });

    // create room with auth
    app.post('/room/create', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }
        const collection = db.collection('room');
        // Insert some documents
        collection.insertOne(req.body, (err, result) => {
            if (err) {
                throw err;
            }
            return res.json(result).end();
        });
    });

    // run Scene with auth
    app.post('/scene/run', verifyToken, (req, res) => {
        if (!req.user) {
            return res.status(401).json({error: "unauthorized"}).end();
        }

        console.log("==========================");
        console.log("Scene Body");
        console.dir(req.body, { depth: 20 });
        console.log("==========================");

        return res.json({"success": true}).end();
    });

});

app.listen(3100, () => console.log('Example app listening on port 3100!'))
