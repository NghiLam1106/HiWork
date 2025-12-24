const bcrypt = require("bcrypt");
const userRepository = require("../../repository/auth/authRepository");
const { auth, admin } = require("../../config/firebaseConfig");

const registerUser = async (userData) => {
  const { username, email, password, role } = userData;

  const existingUser = await userRepository.findUserByEmail(email);
  if (existingUser) {
    throw new Error("Email đã được sử dụng");
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  if (role == "user") {
    const User = await userRepository.createUser({
      username,
      email,
      password: hashedPassword,
      role: "2",
    });

    await auth.createUser({
      uid: User.id.toString(),
      email: User.email,
      password: password,
      displayName: User.name,
    });
    // Gán role vào custom claims
    await admin.auth().setCustomUserClaims(User.id.toString(), { role: "2" });
    return User;
  } else if (role == "manager") {
    const newUser = await userRepository.createUser({
      username,
      email,
      password: hashedPassword,
      role: "1",
    });

    console.log("role value:", newUser.email);
    await auth.createUser({
      uid: newUser.id.toString(),
      email: newUser.email,
      password: password,
      displayName: newUser.username,
    });

    // Gán role vào custom claims
    await admin
      .auth()
      .setCustomUserClaims(newUser.id.toString(), { role: "1" });

    return newUser;
  } else {
    const newUser = await userRepository.createUser({
      username,
      email,
      password: hashedPassword,
      role: "0",
    });

    await auth.createUser({
      uid: newUser.id.toString(),
      email: newUser.email,
      password: password,
      displayName: newUser.username,
    });

    // Gán role vào custom claims
    await admin
      .auth()
      .setCustomUserClaims(newUser.id.toString(), { role: "0" });

    return newUser;
  }
};

const loginUser = async (credentials) => {
  const { email, password } = credentials;

  // Kiểm tra user trong MySQL
  const user = await userRepository.findUserByEmail(email);
  if (!user) {
    throw new Error("Email không tồn tại");
  }

  // Xác thực với Firebase Auth (dùng REST API hoặc Client SDK)
  // Firebase Admin không cho so sánh password trực tiếp
  const fetch = require("node-fetch");
  const firebaseSignInUrl = `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${process.env.FIREBASE_API_KEY}`;
  const firebaseResponse = await fetch(firebaseSignInUrl, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      email,
      password,
      returnSecureToken: true,
    }),
  });

  const firebaseData = await firebaseResponse.json();
  if (firebaseData.error) {
    throw new Error("Mật khẩu không đúng");
  }

  const employee = await userRepository.findEmployeeByUserId(user.id);
  // employee có thể null nếu user chưa được gán nhân viên
  const employeeId = employee?.id ?? null;

  // Trả về thông tin user + Firebase token
  return {
    firebaseToken: firebaseData.idToken,
    user: {
      id: user.id,
      name: user.username,
      email: user.email,
      role: user.role,
    },
    employee: employeeId
      ? {
          id: employeeId,
          name: employee.name,
          phone: employee.phone,
          address: employee.address,
          avatar_url: employee.avatar_url,
          gender: employee.gender,
          date_of_birth: employee.date_of_birth,
          image_check: employee.image_check,
          face_embedding: employee.face_embedding,
          status: employee.status,
          position_id: employee.position.name,
          user_id: employee.user_id,
        }
      : null,
  };
};

module.exports = {
  registerUser,
  loginUser,
};
