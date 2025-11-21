// Tạo một file mới, ví dụ: src/routes/GuestRoute.js
import React from 'react';
import { Navigate } from 'react-router-dom';

const GuestRoute = ({ children }) => {
  // Lấy token từ localStorage (giống như lúc bạn lưu)
  const token = localStorage.getItem("token");

  if (token) {
    // Nếu ĐÃ đăng nhập, chuyển hướng sang trang Home
    // 'replace' sẽ thay thế lịch sử, người dùng không thể nhấn "Back" lại
    return <Navigate to="/admin/home" replace />;
  }

  // Nếu CHƯA đăng nhập, hiển thị component con (chính là trang <Auth />)
  return children;
};

export default GuestRoute;
