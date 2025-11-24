// Tạo một file mới, ví dụ: src/routes/ProtectedRoute.js
import React from 'react';
import { Navigate } from 'react-router-dom';

const ProtectedRoute = ({ children }) => {
  // Lấy token từ localStorage
  const token = localStorage.getItem("token");

  if (!token) {
    // Nếu CHƯA đăng nhập, chuyển hướng về trang Auth
    return <Navigate to="/admin/auth" replace />;
  }

  // Nếu ĐÃ đăng nhập, hiển thị component con (chính là trang <Home />)
  return children;
};

export default ProtectedRoute;
