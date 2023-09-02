const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const Product = require("../models/product");

// // Agregar producto
// productRouter.post("/admin/add-product", admin, async (req, res) => {
//   try {
//     const { name, description, quantity, images, price, category } = req.body;
//     let product = new Product({
//       name,
//       description,
//       images,
//       quantity,
//       price,
//       category,
//     });
//     console.log(req.body);
//     console.log(product);

//     product = await product.save();
//     res.json(product);
//   } catch (e) {
//     // res.status(500).json({ error: e.message });
//   }
// });


// obtner productos por categoria
productRouter.get("/api/products", auth, async (req, res) => {
  try {
    console.log(req.query.category);
    const products = await Product.find({category: req.query.category});

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e.message);
  }
});


// // Borrar productos
// productRouter.post("/admin/delete-products", admin, async (req, res) => {
//   try {
//     const { id } = req.body;
//     let product = await Product.findByIdAndDelete(id);
//     res.json(product);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//     console.log(e.message);
//   }
// });

module.exports = productRouter;
