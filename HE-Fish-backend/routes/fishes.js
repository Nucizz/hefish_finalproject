var express = require('express')
var router = express.Router()
var db = require('./connect')

var multer = require('multer')
var storage = multer.diskStorage({
    destination: function(req, file, cb){
        cb(null, './assets/')
    }, filename: function(req, file, cb){
        cb(null, file.originalname)
    }
})

var upload = multer({storage: storage})

/* GET fishes listing. */
router.get('/', function(req, res, next) {

    const q = "SELECT * FROM fishes"
    db.query(q, (err, result) =>{
        if(err) throw err
        res.send(result)
    })
});

//get fishes image slideshow
router.get('/getCarouselImage', (req, res) => {
    
    const q = "SELECT f.image_path FROM fishes f LIMIT 10"
    db.query(q, (err, result) => {
        if(err) throw err
        res.send(result)
    })
})

// get all fish attr
router.get('/all-fish', (req, res) => {
    
    const q = "SELECT * FROM fishes f JOIN fish_types ft on f.fish_type_id = ft.id JOIN users u on f.user_id = u.id"
    db.query(q, (err, result) => {
        if(err) throw err
        res.send(result)
    })
})

// fish detail query
router.get('/get-fish', (req, res) => {
    const id = req.query.id
    const q = `select * from fishes where id = ${id}`
    db.query(q, (err, result) => {
        if(err) throw err
        res.send(result[0])
    })
})

// fish detail params
router.get('/get-fish/:id', (req, res) => {
    const id = req.params.id
    const q = `select * from fishes where fish_id = ${id}`
    db.query(q, (err, result) => {
        if(err) throw err
        res.send(result[0])
    })
})

// insert fish
router.post('/insert-new-fish', upload.single('image'), (req, res) => {
    const data = req.body
    const file = req.file

    const filePath = `${file.path.replace('\\', '/')}`

    const q = `insert into fishes (user_id, fish_type_id, fish_name, description, price, image_path) 
                values (${data.userID}, ${data.fishType}, '${data.name}', '${data.desc}', ${data.price}, '${filePath}')`
    
    db.query(q, (err, result) => {
        if(err) throw err
        res.send(result)
    })

    // res.json(file.path)
})

// update fish
router.put('/update-fish-image', upload.single('image'), (req, res) => {
    const data = req.body
    const file = req.file

    const filePath = `http://10.0.2.2:3000/${file.path.replace('\\', '/')}`
    const q = `UPDATE fishes SET fish_type_id = ${data.fishType}, fish_name = '${data.name}', description = '${data.desc}', price = ${data.price}, image_path = '${filePath}' WHERE fish_id = '${data.id}'`

    db.query(q, (err, result) => {
        if(err) throw err
        res.send(result)
    })
})

// update fish
router.post('/update-fish', (req, res) => {
    const data = req.body

    const q = `UPDATE fishes SET fish_type_id = ${data.fishType}, fish_name = '${data.name}', description = '${data.desc}', price = ${data.price} WHERE fish_id = '${data.id}'`

    db.query(q, (err, result) => {
        if(err) throw err
        res.send(result)
    })
})

// delete fish
router.delete('/delete-fish', (req, res) => {
    const data = req.body

    const q = `DELETE FROM fishes WHERE fish_id = ${data.id}`

    db.query(q, (err, result) => {
        if(err) throw err
        res.send(result)
    })
})

module.exports = router;