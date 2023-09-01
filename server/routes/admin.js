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
  }
});


// obtner productos
adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    console.log("Si hay productos");

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e.message);
  }
});


// Borrar productos
adminRouter.post("/admin/delete-products", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e.message);
  }
});

module.exports = adminRouter;
