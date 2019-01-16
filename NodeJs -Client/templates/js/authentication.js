'use strict';

function auth (req, res) {
  var uname = req.query.uname, password = req.query.password;
  if (uname === '' || password === '') {
    return res.status(500).send('Enter username and password');
  }
  if (uname === 'pathologist' && password === 'pathologist') {
    return res.status(200).send(req.query.uname + 'Authenticated');
  } else {
    return res.status(500).send('Invalid Credentials');
  }
}
module.exports = {
  auth
};
