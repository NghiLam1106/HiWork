const { user } = require('../../models');

const findUserByEmail = async (email) => {
  return await user.findOne({ where: { email } });
};

const createUser = async (userData) => {
  return await user.create(userData);
};

module.exports = {
  findUserByEmail,
  createUser
};
