const { user, employee } = require('../../models');

const findUserByEmail = async (email) => {
  return await user.findOne({ where: { email } });
};

const createUser = async (userData) => {
  const newUser = await user.create(userData);
  console.log("role value:", newUser.role);
  await employee.create({
    user_id: newUser.id,
    status: "1",
  });
  return newUser;
};

module.exports = {
  findUserByEmail,
  createUser
};
