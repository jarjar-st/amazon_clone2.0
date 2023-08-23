// Imports de paquetes
const express = require('express');
const mongoose = require('mongoose');

// Imports de otros archivos
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');

//? Inicializacion
const PORT = 3001;
const app = express();
const DB = "mongodb+srv://Benjamin:Jxbkm3s09gwmhQpA@cluster0.yrcpb.mongodb.net/amazonClone?retryWrites=true&w=majority";

//? Middlewares
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

//? Conexiones
mongoose.connect(DB).then(() => {
    console.log("Conexion establecida con la base de datos")
}).catch((e) => {
    console.log (e);
});




app.listen(PORT, "0.0.0.0", () => {
    console.log(`Conectado al puerto ${PORT}`);
});