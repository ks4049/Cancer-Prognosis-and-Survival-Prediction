'use strict';
var Array = require('node-array');
var crypto = require('crypto');
var selectedItems = [];
var key = 'thisisthekeyusedtoencrypt';
function addElement (req, res) {
	console.log("in server");
	selectedItems.push(req.query.selectedItem);
	return res.status(200).send(selectedItems);
}
function displayCart(req,res)
{	
	return res.status(200).send(selectedItems);
}
function encrypt(req, res)
{
	var text = req.query.password;
	var key = 'thisisthestring';
	var cipher = crypto.createCipher('aes-256-cbc', key);
	        var crypted = cipher.update(text, 'utf-8', 'hex');
	        crypted += cipher.final('hex');
	  return res.status(200).send(crypted);
}
module.exports = {
  addElement,
  displayCart,
  encrypt
};
