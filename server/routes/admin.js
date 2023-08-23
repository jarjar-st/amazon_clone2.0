const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const Product = require("../models/product");

// Agregar producto
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, quantity, images, price, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    console.log(req.body);
    console.log(product);

    product = await product.save();
    res.json(product);
  } catch (e) {
    // res.status(500).json({ error: e.message });
    console.log(`ESTA ES: ${e.message}`);
  }
});

module.exports = adminRouter;
