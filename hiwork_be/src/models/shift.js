'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class shift extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  shift.init({
    name: DataTypes.STRING,
    startTime: DataTypes.TIME,
    endTime: DataTypes.TIME
  }, {
    sequelize,
    modelName: 'shift',
  });
  return shift;
};