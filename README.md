# Virtual Mixologist

Virtual Mixologist is a web application build in Ruby on Rails for the Muhlenberg College Computer Science CUE in Spring 2023. The website allows users to create, browse, and rate drink recipes, and browse and save liquor products.

**Note:** This application does not come with any data. You must fill your database with your own data.

### Dependencies

- Ruby v3.2.0

- Rails v7.0.4.1

- MySQL v8.0.30

- Bundler gem v2.4.5

### Setup

**Prerequisites:** all dependencies should be installed and configured.

1. Clone the repository to your local device.

2. Create a new file called `.env` inside the root project folder. Copy and paste the following code into that file, replacing "\<password\>" with the MySQL root password:

   ```env
   VIRTUAL_BARTENDER_DATABASE_PASSWORD=<password>
   VIRTUAL_BARTENDER_DEVELOPMENT_DATABASE_PASSWORD=<password>
   ```

3. Open a terminal and navigate to the root project directory. Then, run the following command:

   ```unix
   bundle install
   ```

4. To create a new database, run the following command:

   ```unix
   rails db:create
   ```

5. Make sure the database schema is up to date by running the following command:

   ```unix
   rails db:migrate
   ```

6. Finally, start the server:

   ```unix
   rails server
   ```

7. You should be able to access the website by visiting http://localhost:3000/ in your favorite browser.
