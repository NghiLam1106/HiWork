const admin = require("firebase-admin");

const authMiddleware = async (req, res, next) => {
  const authHeader = req.headers.authorization;

  console.log("Auth Header:", authHeader);

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ message: "Token thiếu hoặc sai định dạng." });
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = await admin.auth().verifyIdToken(token);

    req.user = decoded; // Firebase user info
    next();
  } catch (err) {
    return res.status(401).json({ message: "Token Firebase không hợp lệ." });
  }
};
module.exports = authMiddleware;
