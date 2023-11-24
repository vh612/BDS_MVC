var express = require('express');
var router = express.Router();
var dbconnect =require("../database/connect");

/* GET home page. */
router.get('/', function(req, res, next) {
  dbconnect.query("SELECT * FROM property" ,function(err, data) {
    if(err) throw err;
    res.render('index', {data, data});
  });
});
//add contract
router.get("/add",function(req, res){
  res.render("add");
});
router.post("/add", function(req, res) {
  console.log(req.body);
  const randomId = Math.floor(Math.random() * 10000000); 

  dbconnect.query(
    `INSERT INTO property (name, age, id_card, adress, phone, id_property, date_contract, value_contract, price_stake, price_renk, status )
    VALUES('${req.body.name}','${req.body.age}','${req.body.id_card}','${req.body.adress}','${req.body.phone}','${randomId}','${req.body.date_contract}','${req.body.value_contract}','${req.body.price_stake}','${req.body.price_renk}','${req.body.status}')`,
    function(err) {
      if (err) throw err;
      res.redirect("/");
    }
  );
});


// delete
router.get("/delete/:id",function(req, res){
  dbconnect.query(`DELETE FROM property WHERE id=${req.params.id}`,function(err){
    if(err) throw err;
    res.redirect("/");
  });
});
//edit
router.get("/edit/:id",function(req, res){
  var data = dbconnect.query(`SELECT * FROM property WHERE id=${req.params.id}`, function(err, result){
    if(err) throw err;
    data = {
      id:result[0].id,
      name:result[0].name,
      age:result[0].age,
      id_card:result[0].id_card,
      adress:result[0].adress,
      phone:result[0].phone,
      id_property:result[0].id_property,
      date_contract:result[0].date_contract,
      value_contract:result[0].value_contract,
      price_stake:result[0].price_stake,
      price_renk:result[0].price_renk,
      status:result[0].status,
    }
    res.render("edit",{data});
  });
});
//update

router.post("/edit",function(req, res){
  console.log(req.body); // Log the request body to the console
  dbconnect.query(`UPDATE property SET name='${req.body.name}',age='${req.body.age}',id_card='${req.body.id_card}',adress='${req.body.adress}',phone='${req.body.phone}',id_property='${req.body.id_property}',date_contract='${req.body.date_contract}',value_contract='${req.body.value_contract}',price_stake='${req.body.price_stake}',price_renk='${req.body.price_renk}',status='${req.body.status}' WHERE id='${req.body.id}'`, function(err){
    if(err) throw err;
    res.redirect("/");
  })
});



module.exports = router;
