# Park your Car

![Park Your Car Logo](https://github.com/engwebUM/parkyourcar/blob/master/app/assets/images/white_logo.png)


The idea is brutally simple: we connect drivers in search of 
parking with anyone who has a space going spare, whether in 
a car park, private driveway, church, school, or pub.

### Configuration

This section document whatever steps are necessary to get the
application up and running. We assume that you already set up
your ruby on rails environment.

If you want to run our project from git you have to do the
following commands on your terminal:

1. Clone parkyourcar project from github
`->git clone https://github.com/engwebUM/parkyourcar.git`	

2. Change to parkyourcar folder
`->cd parkyourcar`

3. Make sure all dependencies in your Gemfile are available
to the application
`->bundle install`

4. Create database, load the schema into the current env's
database and populate database
`->rake db:setup`

5. Launch a web server named WEBrick which comes bundled 
with ruby
`->rails server`

After you launch the Rails server (listening on port 3000) go to 
your browser and open http://localhost:3000, you will see 
parkyourcar Rails app running.

### Heroku

Our application can also be seen in Heroku where we realize the 
respective deploy. Heroku is a platform as a service (PaaS) that 
enables developers to build and run applications entirely in the 
cloud.

The link that allows this view is as follows: [Park your Car](https://parkyourcar.herokuapp.com/)
