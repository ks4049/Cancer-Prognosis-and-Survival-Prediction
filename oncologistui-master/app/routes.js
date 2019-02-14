var request = require("request");
var $ = require("jquery")
var express = require('express');
module.exports = function(app, passport) {

// normal routes ===============================================================
app.use(express.static(__dirname + '/public'))
    // show the home page (will also have our login links)
    app.get('/', function(req, res) {
        res.render('index.ejs');
    });
    app.get('/appointment', function(req, res) {
        res.render('appointment.ejs');
    });
    app.get('/forms', function(req, res) {
        res.render('forms.ejs');
    });
    app.post('/report', function(req,res){
        console.log(req.body.patientid);
       request("http://localhost:3000/data_analytics/get_analytics_data?user_id="+req.body.patientid, function(err, resp, body) {
       data = JSON.parse(body);

    console.log(data);

        res.render('report.ejs',{data :data});
              });
           
    });
    // PROFILE SECTION =========================
    app.get('/profile', isLoggedIn, function(req, res) {
        res.render('profile.ejs', {
            user : req.user
        });
    });
    app.get('/input', isLoggedIn, function(req, res) {
        res.render('fuzzy.ejs')

    });

    // LOGOUT ==============================
    app.get('/logout', function(req, res) {
        req.logout();
        res.redirect('/');
    });
    app.post('/fuzzy', function(req, res) {
      console.log(req.body.cholestrol);
      var inp = [
        req.body.cholestrol,
        req.body.obesity
      ];
      var fuzzyis = require('fuzzyis');
      var system = new fuzzyis.FIS('Cancer system');
      var LV = fuzzyis.LinguisticVariable;
       var Term = fuzzyis.Term;
        var Rule = fuzzyis.Rule;
      var outputs = [
    new LV('chance of cancer', [0, 100])
    ];
    var inputs = [
    new LV('obesity', [0, 10]),
    new LV('cholestrol', [0, 10])
];
// take some shortcuts
var CANCER = outputs[0];
var OBESITY = inputs[0];
var CHOLESTROL = inputs[1];

OBESITY.addTerm(new Term('normal', 'gauss', [0, 2.123]));
OBESITY.addTerm(new Term('high', 'gauss', [2.123, 5]));
OBESITY.addTerm(new Term('very high', 'gauss', [5, 10]));

CHOLESTROL.addTerm(new Term('normal', 'gauss', [0,2.123]));
CHOLESTROL.addTerm(new Term('high', 'gauss', [2.123, 5]));
CHOLESTROL.addTerm(new Term('very high', 'gauss', [5, 10]));
CANCER.addTerm(new Term('low', 'triangle', [0, 15, 30]));
CANCER.addTerm(new Term('medium', 'triangle', [30, 45, 60]));
CANCER.addTerm(new Term('high', 'triangle', [60, 75, 90]));

system.inputs = inputs;
system.outputs = outputs;
system.rules = [
    new Rule(
        ['normal', 'normal'],
        ['low'],
        'and'
    ),
    new Rule(
        ['high', 'high'],
        ['medium'],
        'and'
    ),
    new Rule(
        ['very high', 'very high'],
        ['high'],
        'and'
    )
];
var output = system.getPreciseOutput([inp[0],inp[1]]);
res.render('tables.ejs', { output:output})
    });

// =============================================================================
// AUTHENTICATE (FIRST LOGIN) ==================================================
// =============================================================================

    // locally --------------------------------
        // LOGIN ===============================
        // show the login form
        app.get('/login', function(req, res) {
            res.render('login.ejs', { message: req.flash('loginMessage') });
        });

        // process the login form
        app.post('/login', passport.authenticate('local-login', {
            successRedirect : '/profile', // redirect to the secure profile section
            failureRedirect : '/login', // redirect back to the signup page if there is an error
            failureFlash : true // allow flash messages
        }));

        // SIGNUP =================================
        // show the signup form
        app.get('/signup', function(req, res) {
            res.render('signup.ejs', { message: req.flash('signupMessage') });
        });

        // process the signup form
        app.post('/signup', passport.authenticate('local-signup', {
            successRedirect : '/profile', // redirect to the secure profile section
            failureRedirect : '/signup', // redirect back to the signup page if there is an error
            failureFlash : true // allow flash messages
        }));

    // facebook -------------------------------

        // send to facebook to do the authentication
        app.get('/auth/facebook', passport.authenticate('facebook', { scope : 'email' }));

        // handle the callback after facebook has authenticated the user
        app.get('/auth/facebook/callback',
            passport.authenticate('facebook', {
                successRedirect : '/profile',
                failureRedirect : '/'
            }));

    // twitter --------------------------------

        // send to twitter to do the authentication
        app.get('/auth/twitter', passport.authenticate('twitter', { scope : 'email' }));

        // handle the callback after twitter has authenticated the user
        app.get('/auth/twitter/callback',
            passport.authenticate('twitter', {
                successRedirect : '/profile',
                failureRedirect : '/'
            }));


    // google ---------------------------------

        // send to google to do the authentication
        app.get('/auth/google', passport.authenticate('google', { scope : ['profile', 'email'] }));

        // the callback after google has authenticated the user
        app.get('/auth/google/callback',
            passport.authenticate('google', {
                successRedirect : '/profile',
                failureRedirect : '/'
            }));

// =============================================================================
// AUTHORIZE (ALREADY LOGGED IN / CONNECTING OTHER SOCIAL ACCOUNT) =============
// =============================================================================

    // locally --------------------------------
        app.get('/connect/local', function(req, res) {
            res.render('connect-local.ejs', { message: req.flash('loginMessage') });
        });
        app.post('/connect/local', passport.authenticate('local-signup', {
            successRedirect : '/profile', // redirect to the secure profile section
            failureRedirect : '/connect/local', // redirect back to the signup page if there is an error
            failureFlash : true // allow flash messages
        }));

    // facebook -------------------------------

        // send to facebook to do the authentication
        app.get('/connect/facebook', passport.authorize('facebook', { scope : 'email' }));

        // handle the callback after facebook has authorized the user
        app.get('/connect/facebook/callback',
            passport.authorize('facebook', {
                successRedirect : '/profile',
                failureRedirect : '/'
            }));

    // twitter --------------------------------

        // send to twitter to do the authentication
        app.get('/connect/twitter', passport.authorize('twitter', { scope : 'email' }));

        // handle the callback after twitter has authorized the user
        app.get('/connect/twitter/callback',
            passport.authorize('twitter', {
                successRedirect : '/profile',
                failureRedirect : '/'
            }));


    // google ---------------------------------

        // send to google to do the authentication
        app.get('/connect/google', passport.authorize('google', { scope : ['profile', 'email'] }));

        // the callback after google has authorized the user
        app.get('/connect/google/callback',
            passport.authorize('google', {
                successRedirect : '/profile',
                failureRedirect : '/'
            }));

// =============================================================================
// UNLINK ACCOUNTS =============================================================
// =============================================================================
// used to unlink accounts. for social accounts, just remove the token
// for local account, remove email and password
// user account will stay active in case they want to reconnect in the future

    // local -----------------------------------
    app.get('/unlink/local', isLoggedIn, function(req, res) {
        var user            = req.user;
        user.local.email    = undefined;
        user.local.password = undefined;
        user.save(function(err) {
            res.redirect('/profile');
        });
    });

    // facebook -------------------------------
    app.get('/unlink/facebook', isLoggedIn, function(req, res) {
        var user            = req.user;
        user.facebook.token = undefined;
        user.save(function(err) {
            res.redirect('/profile');
        });
    });

    // twitter --------------------------------
    app.get('/unlink/twitter', isLoggedIn, function(req, res) {
        var user           = req.user;
        user.twitter.token = undefined;
        user.save(function(err) {
            res.redirect('/profile');
        });
    });

    // google ---------------------------------
    app.get('/unlink/google', isLoggedIn, function(req, res) {
        var user          = req.user;
        user.google.token = undefined;
        user.save(function(err) {
            res.redirect('/profile');
        });
    });


};

// route middleware to ensure user is logged in
function isLoggedIn(req, res, next) {
    if (req.isAuthenticated())
        return next();

    res.redirect('/');
}
