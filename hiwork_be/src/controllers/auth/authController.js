const { registerUser, loginUser } = require('../../service/auth/authService');

const register = async (req, res) => {
  try {
    const newUser = await registerUser(req.body);
    res.status(201).json({ message: 'Đăng ký thành công', user: newUser });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const login = async (req, res) => {
  try {
    const user = await loginUser(req.body);
    res.status(200).json({ message: 'Đăng nhập thành công', user });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = {
  register,
  login
};
