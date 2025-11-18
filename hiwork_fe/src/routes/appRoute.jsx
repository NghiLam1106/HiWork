import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";
import Auth from "../page/auth/auth";
import Home from "../page/home/homePage";
import MainLayout from "../layouts/MainLayout";
import User from "../page/user/userPage";
import Profile from "../page/profile/profilePage";
import Position from "../page/position/positionPage";
import AddPosition from "../page/position/addPositionPage";
import DetailPosition from "../page/position/detailPositionPage";

// 1. Import 2 component mới
import ProtectedRoute from "./ProtectedRoute"; // (Kiểm tra lại đường dẫn file)
import GuestRoute from "./GuestRoute"; // (Kiểm tra lại đường dẫn file)

const AppRoutes = () => (
  <BrowserRouter>
    <Routes>
      {/* Route mặc định, tự động chuyển hướng */}
      <Route path="/" element={<Navigate to="/home" replace />} />

      {/* Bọc <Auth /> bằng <GuestRoute /> */}
      <Route
        path="/auth"
        element={
          <GuestRoute>
            <Auth />
          </GuestRoute>
        }
      />

      {/* 4. Bọc các trang còn lại bằng <ProtectedRoute /> */}
      <Route
        element={
          <ProtectedRoute>
            <MainLayout>
            </MainLayout>
          </ProtectedRoute>
        }
      >
        <Route path="/home" element={<Home />} />
        <Route path="/nhan-vien/danh-sach" element={<User />} />
        <Route path="/nhan-vien/:id" element={<Profile />} />
        <Route path="/vi-tri/them-moi" element={<AddPosition />} />
        <Route path="/vi-tri/danh-sach" element={<Position />} />
        <Route path="/vi-tri/danh-sach/:id" element={<DetailPosition />} />
      </Route>
    </Routes>
  </BrowserRouter>
);

export default AppRoutes;
