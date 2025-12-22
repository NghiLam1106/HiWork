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

const findEmployeeByUserId = async (userId) => {
  return employee.findOne({
    where: { user_id: userId }, // <-- đổi theo schema của bạn
    attributes: ["id", "user_id"],
  });
}

module.exports = {
  findUserByEmail,
  createUser,
  findEmployeeByUserId,
};
