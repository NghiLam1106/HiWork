"use strict";
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable("attendances", {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },
      id_EmployeeShift: {
        type: Sequelize.INTEGER,
        references: { model: "employee_schedules", key: "id" },
        onUpdate: "CASCADE",
        onDelete: "CASCADE",
      },
      checkIn: {
        type: Sequelize.DATE,
      },
      checkOut: {
        type: Sequelize.DATE,
      },
      photoUrl: {
        type: Sequelize.STRING,
      },
      confidenceScore: {
        type: Sequelize.FLOAT,
      },
      status: {
        type: Sequelize.STRING,
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable("attendances");
  },
};
