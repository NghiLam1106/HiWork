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
  }
};

module.exports = profileService;
