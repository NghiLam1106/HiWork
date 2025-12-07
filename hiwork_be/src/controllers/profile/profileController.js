const profileService = require("../../service/profile/profileService");

const profileController = {
  // Lấy thông tin profile từ userId trong token
  async getProfile(req, res) {
    try {
      const userId = req.params.id; // authMiddleware gắn vào req.user
      const user = await profileService.getProfile(userId);
      return res.json({ user });
    } catch (error) {
      return res.status(500).json({
        message: "Lỗi server khi lấy thông tin người dùng",
      });
    }
  },

  // Cập nhật thông tin người dùng
  async updateProfile(req, res) {
    try {
      const userId = req.params.id;
      const updateData = req.body;

      const updatedUser = await profileService.updateProfile(
        userId,
        updateData
      );

      return res.json({
        message: "Cập nhật thành công",
        user: updatedUser,
      });
    } catch (error) {
      console.error(error);
      return res.status(500).json({
        message: "Lỗi server khi cập nhật thông tin",
      });
    }
  },

  // Cập nhật avatar người dùng
  async updateAvatar(req, res) {
    try {
      const userId = req.params.id;
      console.log("Received file:", req.file);

      const imageUrl = req.file.secure_url || req.file.path;

      if (!imageUrl) {
        return res.status(400).json({ message: "Không thể lấy URL ảnh!" });
      }

      await profileService.updateAvatar(userId, imageUrl);

      return res.json({
        message: "Cập nhật avatar thành công!",
        avatar_url: imageUrl,
      });
    } catch (err) {
      console.error("UPLOAD ERROR:", err.message, err);
      return res.status(500).json({ message: "Lỗi server cập nhật avatar" });
    }
  },
};

module.exports = profileController;
