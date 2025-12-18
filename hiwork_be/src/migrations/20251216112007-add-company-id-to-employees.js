'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.addColumn("employees", "company_id", {
      type: Sequelize.INTEGER,
      allowNull: true,
      references: {
        model: "companies",
        key: "id",
      },
      onUpdate: "CASCADE",
      onDelete: "SET NULL",
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.removeColumn("employees", "company_id");
  }
};
