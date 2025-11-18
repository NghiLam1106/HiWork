export const validateLogin = (email, password) => {
  if (!email || !password) {
    return "Vui lòng nhập đầy đủ thông tin!";
  }

  // Validate định dạng email
  const emailRegex = /\S+@\S+\.\S+/;
  if (!emailRegex.test(email)) {
    return "Email không hợp lệ!";
  }

  // Validate độ dài mật khẩu
  if (password.length < 6) {
    return "Mật khẩu phải có ít nhất 6 ký tự!";
  }

  return null; // ✅ Không có lỗi
};
