'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class attendances extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.employeeSchedule, {
        foreignKey: "id_EmployeeShift",
        as: "employeeSchedule",
      });
    }
  }
  attendances.init({
  id_EmployeeShift: DataTypes.INTEGER,
  checkIn: DataTypes.DATE,
  checkOut: DataTypes.DATE,
  photoUrl: DataTypes.STRING,
  confidenceScore: DataTypes.FLOAT,
  status: DataTypes.INTEGER,
}, {
  sequelize,
  modelName: "attendances",
  tableName: "attendances",
});
  return attendances;
};
