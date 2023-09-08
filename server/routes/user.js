const express = require("express");
const auth = require("../middlewares/auth");
const userRouter = express.Router();
const { Product } = require("../models/product");
const User = require("../models/user");


userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {

      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }
      if (isProductFound) {
        let selectedProduct = user.cart.find((productToFind) =>
          productToFind.product._id.equals(product._id)
        );
        selectedProduct.quantity += 1;
      } else{
        user.cart.push({product, quantity: 1});
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    console.log("Aquiiiii");

    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
