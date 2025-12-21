'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.addColumn("employees", "date_of_birth", {
      type: Sequelize.DATEONLY, // chỉ ngày, không cần giờ
      allowNull: true,
    });

    // Ảnh nhận dạng (URL ảnh lưu Cloudinary/Firebase/S3...)
    await queryInterface.addColumn("employees", "image_check", {
      type: Sequelize.STRING(500),
      allowNull: true,
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.removeColumn("employees", "image_check");
    await queryInterface.removeColumn("employees", "date_of_birth");
  }
};
