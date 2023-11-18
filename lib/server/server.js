const express = require('express');
const AWS = require('aws-sdk');
const config = require('./config');
const app = express();
const port = 3000;

const mysql = require('mysql');

// AWS configuration
AWS.config.update({
    accessKeyId: config.AWS_ACCESS_KEY_ID,
    secretAccessKey: config.AWS_SECRET_ACCESS_KEY,
    sessionToken: config.AWS_SESSION_TOKEN,
    region: config.AWS_REGION,
});

// Create an instance of the S3 service
const s3 = new AWS.S3();

// Database connection setup
const db = mysql.createConnection({
  host: 'jommakan.c1efdodxxtlq.us-east-1.rds.amazonaws.com',
  user: 'admin',
  password: 'fypjommakan',
  database: 'jommakan',
});

db.connect((err) => {
  if (err) {
    console.error('Database connection failed: ' + err.stack);
    return;
  }
  console.log('Connected to database');
});

// Define a route to get all foods
app.get('/get-all-foods', (req, res) => {
  // Extract the search query from the request parameters
  const searchQuery = req.query.search;

  // Extract other filter criteria
  const priceRangeMin = req.query.priceRangeMin;
  const priceRangeMax = req.query.priceRangeMax;
  const minRating = req.query.minRating;
  const selectedLocations = req.query.locations ? req.query.locations.split(',') : null;
  const selectedCategories = req.query.categories ? req.query.categories.split(',') : null;

  let query = `
    SELECT
      foods.foodID,
      foods.food_name,
      stalls.stall_name,
      foods.food_price,
      foods.qty_in_stock,
      foods.food_image
    FROM
      foods
    JOIN
      stalls ON foods.stallID = stalls.stallID
    WHERE
      UPPER(foods.food_name) LIKE UPPER(?)
  `;

  // Use '%' in the query to match any substring of the food name
  const searchValue = searchQuery ? `%${searchQuery}%` : '%';
  console.log('Search Value triggered: ', searchValue);

  // Add conditions for each filter
  if (searchQuery) {
    console.log('Search query called: ', searchQuery);
    query += ` AND UPPER(foods.food_name) LIKE UPPER('%${searchQuery}%')`;
  }

  if (priceRangeMin && priceRangeMax) {
    query += ` AND foods.food_price BETWEEN ${priceRangeMin} AND ${priceRangeMax}`;
  }

  if (minRating) {
    query += ` AND foods.rating >= ${minRating}`;
  }

  if (selectedLocations) {
    query += ` AND stalls.location IN ('${selectedLocations.join("','")}')`;
  }

  if (selectedCategories) {
    query += ` AND foods.category IN ('${selectedCategories.join("','")}')`;
  }

  db.query(query, [searchValue], (err, results) => {
    if (err) {
      console.error('Database query error: ' + err.stack);
      res.status(500).json({ success: false, error: 'Database query error' });
    } else {
      const foods = results.map((food) => ({
        foodID: food.foodID,
        food_name: food.food_name,
        stall_name: food.stall_name,
        food_price: food.food_price,
        qty_in_stock: food.qty_in_stock,
        food_image_url: getFoodImageUrl("foods/" + food.food_image),
      }));

      res.json({ success: true, foods });
    }
  });
});

// Define a function to get S3 URL for food image
function getFoodImageUrl(s3Key) {
  // Logic to generate S3 URL
  const params = {
    Bucket: config.custombucket,
    Key: s3Key,
    Expires: 3600, // URL expiration time in seconds
  };

  // Use the s3 instance to get a signed URL
  const url = s3.getSignedUrl('getObject', params);
  return url;
}

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
