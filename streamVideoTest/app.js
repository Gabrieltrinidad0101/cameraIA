const express = require("express");
const path = require("path");
const app = express()

app.use(express.static(path.join(__dirname, 'public')));

app.listen(3000,()=>{
    console.log("Start the stream videos in the port 3000")
})