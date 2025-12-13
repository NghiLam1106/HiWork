import { useEffect, useState } from "react";
import apiClient from "../../../api/clientAppi"; // import api client
import DashboardCard from "../../../components/DashboardCard";
import EmployeeTable from "../../../components/EmployeeTable";
import SearchBar from "../../../layouts/SearchBar";
import "./homePage.css";

const Home = () => {
  const [positionCount, setPositionCount] = useState(0); // số lượng vị trí
  const [employeeCount, setEmployeeCount] = useState(0); // số lượng nhân viên
  const userRole = localStorage.getItem("role"); // lấy role người dùng từ localStorage

  useEffect(() => {
    const fetchPositionCount = async () => {
      try {
        const resPosition = await apiClient.get("/manager/positions?limit=1"); // lấy 1 item để đọc pagination
        const totalPosition = resPosition.data.pagination?.totalItems || 0; // backend trả về tổng số items
        const resEmployee = await apiClient.get(`/manager/employees?limit=1&role=${userRole}`); // lấy 1 item để đọc pagination
        const totalEmployee = resEmployee.data.pagination?.totalItems || 0; // backend trả về tổng số items
        setPositionCount(totalPosition);
        setEmployeeCount(totalEmployee);
      } catch (err) {
        console.error("Lỗi khi lấy số lượng vị trí:", err);
        setPositionCount(0);
      }
    };

    fetchPositionCount();
  }, []);

  return (
    <>
      <header className="header">
        <h1>Dashboard</h1>
        <SearchBar />
      </header>

      <div className="dashboard-cards">
        <DashboardCard title="Nhân viên" number={employeeCount} color="#4CAF50" />
        <DashboardCard title="Vị trí" number={positionCount} color="#2196F3" />
        <DashboardCard title="Chấm công hôm nay" number={95} color="#FF9800" />
        <DashboardCard title="Nghỉ phép" number={5} color="#F44336" />
      </div>

      <EmployeeTable />
    </>
  );
};

export default Home;
