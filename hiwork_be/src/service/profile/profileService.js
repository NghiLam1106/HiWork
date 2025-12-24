const profileRepository = require("../../repository/profile/profileRepository");

const profileService = {
  async getProfile(userId) {
    return await profileRepository.findById(userId);
  },

  async updateProfile(userId, updateData) {
    await profileRepository.updateById(userId, updateData);
    return await profileRepository.findById(userId); // trả về profile mới
  },

  async updateAvatar(userId, avatarUrl) {
    return await profileRepository.updateAvatar(userId, avatarUrl);
  },

  async updateProfileEmployee(req) {
    await profileRepository.updateProfileEmployee(req);
    const employee = await profileRepository.findEmployeeById(req.id);
    return {
      employee: employee.id
        ? {
            id: employee.id,
            name: employee.name,
            phone: employee.phone,
            address: employee.address,
            avatar_url: employee.avatar_url,
            gender: employee.gender,
            date_of_birth: employee.date_of_birth,
            image_check: employee.image_check,
            face_embedding: employee.face_embedding,
            status: employee.status,
            position_id: employee.position.name,
            user_id: employee.user_id,
          }
        : null,
    };
  },
};

module.exports = profileService;
