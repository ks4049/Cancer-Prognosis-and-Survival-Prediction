'use strict'
var express = require('express');
var session = require('express-session');
var cookieParser = require('cookie-parser');
var flag=0;
//var morgan = require('morgan');
var app = express();
app.use(cookieParser());
app.set('view engine','ejs');
app.use(session({secret:'checkingthepassword',saveUninitialized:true,resave:true}));
var CartDetails = require('./js/cartDetails');
app.use(express.static(__dirname + '/templates'));
app.get('/', function (req, res) {		
	res.render('CanPro.ejs');
});
app.get('/veg_display', function (req, res) { 
if(req.session.user_id){		
   res.render('fooddisplay.ejs', {
	        user_id : req.session.user_id 
	     });
}
});
app.get('/cart_items', function (req, res) { 
   console.log(req.session.user_id);
   if(req.session.user_id){
	   res.render('CartItemsDetails.ejs',{
	        user_id : req.session.user_id 
	     });
	}
});
app.get('/products_display', function (req, res) { 
	if(req.session.user_id){
   res.render('products_display.ejs');
}
});

app.get('/encryptPassword', CartDetails.encrypt);

app.get('/dashboard', function (req, res) { 
	console.log('================');
	console.log(flag);
	if(flag==0)
	{ 
	if(req.query.user_id!=null)
	{   console.log("jwkrtswadl");
		req.session.user_id = req.query.user_id;
	    flag=1;
	}
	else{
		console.log("khavz");
	}}	
	console.log(req.session.user_id);
	if(req.session.user_id ){
		 res.render('dashboard.ejs', {
	        user_id : req.session.user_id 
	     });
	}
	else
	{		
		res.redirect('/');
	 } 
 //res.render('/dashboard.ejs');
});
app.get('/display', function (req, res) {
	if(req.session.user_id){
	res.render('homepage.ejs');
}
});
app.get('/yourorders', function (req, res) {
	if(req.session.user_id){
	res.render('yourorders.ejs',{
	        user_id : req.session.user_id 
	     });
}
});
app.get('/food_display', function (req, res) {
	if(req.session.user_id){
	res.render('fooddisplay.ejs');
}
});

app.get('/logout', function (req, res){
req.session.destroy(function(err) {
  if(err) {
    console.log(err);
  } else {
  	flag=0;
    res.redirect('/');
  }
});
});

app.get('/cosmeticsDisplay', function (req, res){
	if(req.session.user_id){
	res.render('cosmeticsDisplay.ejs');
}
});
app.get('/gadgets_display', function(req, res)
{
	if(req.session.user_id){
	res.render('gadgetsDisplay.ejs');
}
})
app.listen(4000);
console.log('Login/Signup example\nlistening to port 4000');
