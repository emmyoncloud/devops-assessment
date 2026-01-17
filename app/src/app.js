const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get("/health", (req, res) => {
  res.status(200).json({ status: "Healthy!" });
});

app.get("/status", (req, res) => {
  res.status(200).json({
    service: "devops-app",
    uptime: process.uptime(),
    timestamp: new Date().toISOString()
  });
});

app.post("/process", (req, res) => {
  const payload = req.body;

  if (!payload || Object.keys(payload).length === 0) {
    return res.status(400).json({ message: "Invalid payload" });
  }

  res.status(200).json({
    message: "Payload processed successfully",
    data: payload
  });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
