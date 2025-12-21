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
import Employee from "../page/admin/employee/employeePage";
import UpdateEmployee from "../page/admin/employee/updateEmployeePage";
import EmployeeManager from "../page/manager/employee/employeePage";
import UpdateEmployeeManager from "../page/manager/employee/updateEmployeePage";
import Company from "../page/manager/company/companyPage";
import AddCompany from "../page/manager/company/addCompanyPage";
import DetailCompany from "../page/manager/company/detailCompanyPage";

// 1. Import 2 component mới
import GuestRoute from "./GuestRoute"; // (Kiểm tra lại đường dẫn file)
import ProtectedRoute from "./ProtectedRoute"; // (Kiểm tra lại đường dẫn file)
import EmployeeShiftPage from "../page/manager/employeeShift/employeeShiftPage";
import AddEmployeeShift from "../page/manager/employeeShift/addEmployeeShiftPage";
import UpdateEmployeeShift from "../page/manager/employeeShift/updateEmployeeShiftPage";

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
        <Route path="/manager/nhan-vien/:id" element={<EmployeeManager />} />
        <Route path="/manager/nhan-vien/:id/edit" element={<UpdateEmployeeManager />} />
        <Route path="/manager/vi-tri/them-moi" element={<AddPosition />} />
        <Route path="/manager/vi-tri" element={<Position />} />
        <Route path="/manager/vi-tri/:id" element={<DetailPosition />} />
        <Route path="/manager/ca-lam" element={<Shift />} />
        <Route path="/manager/ca-lam/them-moi" element={<AddShift />} />
        <Route path="/manager/ca-lam/:id" element={<DetailShift />} />
        <Route path="/manager/profile/:id" element={<Profile />} />
        <Route path="/manager/profile/:id/edit" element={<UpdateProfile />} />
        <Route path="/manager/cong-ty" element={<Company />} />
        <Route path="/manager/cong-ty/them-moi" element={<AddCompany />} />
        <Route path="/manager/cong-ty/:id" element={<DetailCompany />} />
        <Route path="/manager/lich-lam-viec" element={<EmployeeShiftPage />} />
        <Route path="/manager/lich-lam-viec/them-moi" element={<AddEmployeeShift />} />
        <Route path="/manager/lich-lam-viec/:id" element={<UpdateEmployeeShift />} />

        {/* Trang admin */}
        <Route path="/admin/home" element={<HomeAdmin />} />
        <Route path="/admin/nhan-vien/:id" element={<Employee />} />
        <Route path="/admin/nhan-vien/:id/edit" element={<UpdateEmployee />} />
      </Route>
    </Routes>
  </BrowserRouter>
);

export default AppRoutes;
