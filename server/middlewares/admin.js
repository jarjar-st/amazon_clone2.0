const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res
        .status(401)
        .json({ msg: "No hay token de autorizacion, acceso denegado" });
    }

    const verified = jwt.verify(token, "passwordKey");
    if (!verified) {
      return res
        .status(401)
        .json({ msg: "Verificacion del token fallo, autorizacion denegada"});
    }

    const user = await User.findById(verified.id);
    if (user.type == "user" || user.type == "seller") {
        return res
        .status(401)
        .json({ msg: "No eres un admin, autorizacion denegada"});


        
    }
    req.user = verified.id;
    req.token = token;
    next();

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = admin;

