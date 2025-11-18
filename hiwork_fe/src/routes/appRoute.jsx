import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";
import Auth from "../page/auth/auth";
import Home from "../page/home/homePage";
import MainLayout from "../layouts/MainLayout";

// 1. Import 2 component mới
import ProtectedRoute from "./ProtectedRoute"; // (Kiểm tra lại đường dẫn file)
import GuestRoute from "./GuestRoute";     // (Kiểm tra lại đường dẫn file)

const AppRoutes = () => (
  <BrowserRouter>
    <Routes>
      {/* 2. Thêm route mặc định, tự động chuyển hướng */}
      <Route
        path="/"
        element={<Navigate to="/home" replace />}
      />

      {/* 3. Bọc <Auth /> bằng <GuestRoute /> */}
      <Route
        path="/auth"
        element={
          <GuestRoute>
            <Auth />
          </GuestRoute>
        }
      />

      {/* 4. Bọc <Home /> bằng <ProtectedRoute /> */}
      <Route
        path="/home"
        element={
          <ProtectedRoute>
            <MainLayout>
              <Home />
            </MainLayout>
          </ProtectedRoute>
        }
      />
    </Routes>
  </BrowserRouter>
);

export default AppRoutes;
