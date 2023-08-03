const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");

//?Registra usuario
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    console.log(req.body);

    const existingUser = await User.findOne({ email });

    if (existingUser) {
      console.log("Ya existe el usuairio");
      return res
        .status(400)
        .json({ msg: "Usuario con el mismo email ya existe" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    var user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    console.log(user);
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//?Logear usuario

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: "Usuario con este correo no existe" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ msg: "Contraseña incorrecta" });
    }
    const token = jwt.sign({id: user._id}, "passwordKey");

    res.json({token, ...user._doc});
  } catch (error) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = authRouter;
