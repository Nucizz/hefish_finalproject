var express = require('express')
var router = express.Router()
var db = require('./connect')

function getHash(str) {
  const len = str.length
  var strSplit = str.split("")
  var strReverse = strSplit.reverse()
  var reversedStr = strReverse.join("")
  let hash = 0;
  for (let i=0;i<len;i++) {
      let chr = reversedStr.charCodeAt(i);
      hash = (hash << 5) - hash + chr;
  }
  return hash;
}

/* GET users listing. */
router.get('/', function(req, res, next) {

  const q = "select * from users"
  db.query(q, (err, result) => {
    if(err) throw err
    res.send(result)
  })
})

// user detail params
router.get('/get-user/:id', (req, res) => {
  const id = req.params.id
  const q = `select * from users where id = ${id}`
  db.query(q, (err, result) => {
    if(err) throw err
    res.send(result[0])
  })
})

//chek duplication
router.post('/register-check-username', (req, res) => {
  const data = req.body
  const q = `SELECT * FROM users u WHERE u.username LIKE '${data.username}'`

  db.query(q, (err, result) => {
    if(err) throw err

    if(result.length > 0) res.sendStatus(200)
    else res.sendStatus(404)
  })
})

router.post('/register-check-email', (req, res) => {
  const data = req.body
  const q = `SELECT * FROM users u WHERE u.email LIKE '${data.email}'`

  db.query(q, (err, result) => {
    if(err) throw err

    if(result.length > 0) res.sendStatus(200)
    else res.sendStatus(404)
  })
})

// register user
router.post('/register', (req, res) => {
  const data = req.body
  const hashed = getHash(data.password)

  const q = `INSERT INTO users (email, username, password)
              VALUES (LOWER('${data.email}'), LOWER('${data.username}'), '${hashed}')`

  db.query(q, (err, result) => {
    if(err) throw err
    res.send(result)
  })
})

router.post('/register-oauth', (req, res) => {
  const data = req.body
  
  var token = '';
  var regexp = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var len = regexp.length;
  for ( var i = 0; i < 10; i++ ) {
      token += regexp.charAt(Math.floor(Math.random() * len));
  }

  const q = `INSERT INTO users (email, username, token)
              VALUES (LOWER('${data.email}'), LOWER('${data.username}'), '${token}')`

  db.query(q, (err, result) => {
    if(err) throw err
    res.send(result)
  })
})

// user login
router.post('/login', (req, res) => {
  const data = req.body
  const hashed = getHash(data.password)

  const q = `SELECT u.id, u.username, u.email, u.token FROM users u WHERE username = '${data.username}' AND password = '${hashed}'`
  
  db.query(q, (err, result) => {
    if(err) throw err
    res.send(result)
  })
})

router.post('/login-oauth', (req, res) => {
  const data = req.body

  const q = `SELECT u.id, u.username, u.email, u.token FROM users u WHERE email = '${data.email}' AND LENGTH(u.token) = 10`
  
  db.query(q, (err, result) => {
    if(err) throw err
    
    res.send(result)
  })
})

module.exports = router;
