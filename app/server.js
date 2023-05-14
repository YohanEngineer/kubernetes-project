const express = require("express");
const app = express();
const PORT = 8080;
const HOST = "0.0.0.0";

const ExpressRedisCache = require("express-redis-cache");

const connectToRedis = () => {
  const cache = ExpressRedisCache({
    host: "localhost",
    port: 6379,
    expire: 60,
    retry_strategy: function (options) {
      if (options.error && options.error.code === "ECONNREFUSED") {
        // Connexion refusée - retourne une erreur pour arrêter la connexion
        return new Error("The server refused the connection");
      }
      // Réessaye après 1 seconde
      return 1000;
    },
  });

  cache.on("error", (err) => {
    console.error("Redis error:", err);
  });

  cache.on("connected", () => {
    console.log("Connected to Redis");
  });

  return cache;
};

const cache = connectToRedis();

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
