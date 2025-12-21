'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.changeColumn("attendances", "status", {
      type: Sequelize.INTEGER,
      allowNull: true, // hoặc false tuỳ bạn
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.changeColumn("attendances", "status", {
      type: Sequelize.STRING,
      allowNull: true,
    });
  }
};
