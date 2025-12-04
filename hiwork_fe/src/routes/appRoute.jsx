import { BrowserRouter, Navigate, Route, Routes } from "react-router-dom";
import MainLayout from "../layouts/MainLayout";
import HomeAdmin from "../page/admin/home/homePage";
import Auth from "../page/auth/auth";
import Home from "../page/manager/home/homePage";
import AddPosition from "../page/manager/position/addPositionPage";
import DetailPosition from "../page/manager/position/detailPositionPage";
import Position from "../page/manager/position/positionPage";
import Profile from "../page/manager/profile/profilePage";
import AddShift from "../page/manager/shift/addShiftsPage";
import DetailShift from "../page/manager/shift/detailShiftsPage";
import Shift from "../page/manager/shift/shiftPage";
import User from "../page/manager/user/userPage";
import UpdateProfile from "../page/manager/profile/updateProfilePage";

// 1. Import 2 component mới
import GuestRoute from "./GuestRoute"; // (Kiểm tra lại đường dẫn file)
import ProtectedRoute from "./ProtectedRoute"; // (Kiểm tra lại đường dẫn file)

const AppRoutes = () => (
  <BrowserRouter>
    <Routes>
      {/* Route mặc định, tự động chuyển hướng */}
      <Route path="/" element={<Navigate to="/manager/home" replace />} />

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
        {/* Trang manager */}
        <Route path="/manager/home" element={<Home />} />
        <Route path="/manager/nhan-vien" element={<User />} />
        <Route path="/manager/nhan-vien/:id" element={<Profile />} />
        <Route path="/manager/vi-tri/them-moi" element={<AddPosition />} />
        <Route path="/manager/vi-tri" element={<Position />} />
        <Route path="/manager/vi-tri/:id" element={<DetailPosition />} />
        <Route path="/manager/ca-lam" element={<Shift />} />
        <Route path="/manager/ca-lam/them-moi" element={<AddShift />} />
        <Route path="/manager/ca-lam/:id" element={<DetailShift />} />
        <Route path="/manager/profile/:id" element={<Profile />} />
        <Route path="/manager/profile/:id/edit" element={<UpdateProfile />} />

        {/* Trang admin */}
        <Route path="/admin/home" element={<HomeAdmin />} />
      </Route>
    </Routes>
  </BrowserRouter>
);

export default AppRoutes;
