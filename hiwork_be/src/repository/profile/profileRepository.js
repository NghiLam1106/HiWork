const { employee, user, position } = require("../../models");

class ProfileRepository {
  // 🔍 Lấy thông tin người dùng theo ID
  async findById(userId) {
    return await employee.findOne({
      where: { user_id: userId },
      include: [{ model: user, as: "user", attributes: ["email", "role"] }, { model: position, as: "position", attributes: ["name"]  }]
    });
  }

  // ✏️ Cập nhật thông tin người dùng theo ID
  async updateById(userId, updateData) {
    return await employee.update(updateData, {
      where: { user_id: userId },
    });
  }

  // 🔍 Tìm user theo email (phục vụ check trùng email khi update)
  async findByEmail(email) {
    return await employee.findOne({
      where: { email },
    });
  }

  // 🔍 Tìm user theo số điện thoại
  async findByPhone(phone) {
    return await employee.findOne({
      where: { phone },
    });
  }

    // ✏️ Cập nhật avatar người dùng
  async updateAvatar(userId, avatarUrl) {
    return await employee.update(
      { avatar_url: avatarUrl },
      { where: { user_id: userId } }
    );
  }
}

module.exports = new ProfileRepository();
