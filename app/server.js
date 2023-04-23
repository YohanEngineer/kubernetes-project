const express = require("express");
const app = express();
const PORT = 8080;
const HOST = "0.0.0.0";

const ExpressRedisCache = require("express-redis-cache");
const cache = ExpressRedisCache({
  host: "redis",
  port: 6379,
  // cache expire after 10 seconds
  expire: 60,
});

let value = 0;

app.get("/", (req, res) => {
  res.send("Welcome to the API");
});

app.get("/read", cache.route(), (req, res) => {
  console.log("Getting value: " + value);
  res.send("Getting value: " + value);
});

app.post("/create", (req, res) => {
  var body = "";
  req.on("data", function (data) {
    body += data;
    console.log("Creating value: " + value);
    res.send("Creating value: " + value);
  });
  req.on("end", function () {
    value = body;
  });
});

app.listen(PORT, HOST, () => {
  console.log(`Our APP is listening on port ${PORT}`);
});
