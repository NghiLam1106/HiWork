const multer = require("multer");
const cloudinary = require("../config/cloudinaryConfig");
const { CloudinaryStorage } = require("multer-storage-cloudinary");

const storage = new CloudinaryStorage({
  cloudinary: cloudinary,
  params: {
    folder: "hiwork/avatar",
    allowed_formats: ["jpg", "png", "jpeg", "webp"], // rất quan trọng
    public_id: (req, file) => {
      return `avatar_user_${req.params.id}`;
    },
  },
});

const uploadAvatar = multer({ storage });

module.exports = uploadAvatar;
