'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class employee extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  employee.init({
    name: DataTypes.STRING,
    phone: DataTypes.STRING,
    gender: DataTypes.INTEGER,
    address: DataTypes.STRING,
    avatar_url: DataTypes.STRING,
    face_embedding: DataTypes.STRING,
    status: DataTypes.INTEGER,
    position_id: DataTypes.INTEGER,
    user_id: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'employee',
  });
  return employee;
};