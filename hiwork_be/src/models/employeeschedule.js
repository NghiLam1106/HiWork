'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class employeeSchedule extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      employeeSchedule.belongsTo(models.employee, {
        foreignKey: "id_employee",
        as: "employee",
      });

      employeeSchedule.belongsTo(models.shift, {
        foreignKey: "id_shift",
        as: "shift",
      });
    }
  }
  employeeSchedule.init({
    id_employee: DataTypes.INTEGER,
    id_shift: DataTypes.INTEGER,
    work_date: DataTypes.DATEONLY,
    status: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'employeeSchedule',
    tableName: "employee_schedules",
  });
  return employeeSchedule;
};
