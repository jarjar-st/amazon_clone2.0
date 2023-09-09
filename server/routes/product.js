const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const {Product} = require("../models/product");

// obtner productos por categoria
productRouter.get("/api/products", auth, async (req, res) => {
  try {
    console.log(req.query.category);
    const products = await Product.find({ category: req.query.category });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//Busqueda de productos
productRouter.get("/api/products/search/:search", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.search, $options: "i" },
    });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// calificar productos
productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);
    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
      
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.ratings.push(ratingSchema);
    product = await product.save();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//Oferta del dia
productRouter.get("/api/deal-of-day", auth, async (req, res) => {
  try {
    let totalRating = 0;
    let productRating = 0;
    let mostRating = 0;
    let mostRatingProduct = 0;
    let products = await Product.find({});
    for (let i = 0; i < products.length; i++) {
      for (let j = 0; j < products[i].ratings.length; j++) {
        totalRating += products[i].ratings[j].rating;
      }
      productRating = totalRating/products[i].ratings.length;
      totalRating = 0;
      if (productRating > mostRating) {
        mostRating = productRating;
        mostRatingProduct = i;
      }

    }

    res.json(products[mostRatingProduct]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
