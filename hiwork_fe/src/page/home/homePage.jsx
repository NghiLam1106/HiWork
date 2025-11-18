import { useEffect, useState } from "react";
import DashboardCard from "../../components/DashboardCard";
import EmployeeTable from "../../components/EmployeeTable";
import SearchBar from "../../layouts/SearchBar";
import apiClient from "../../api/clientAppi"; // import api client
import "../home/homePage.css";

const Home = () => {
  const [positionCount, setPositionCount] = useState(0); // số lượng vị trí

  useEffect(() => {
    const fetchPositionCount = async () => {
      try {
        const res = await apiClient.get("/positions?limit=1"); // lấy 1 item để đọc pagination
        const total = res.data.pagination?.totalItems || 0; // backend trả về tổng số items
        setPositionCount(total);
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
        <DashboardCard title="Nhân viên" number={120} color="#4CAF50" />
        <DashboardCard title="Vị trí" number={positionCount} color="#2196F3" />
        <DashboardCard title="Chấm công hôm nay" number={95} color="#FF9800" />
        <DashboardCard title="Nghỉ phép" number={5} color="#F44336" />
      </div>

      <EmployeeTable />
    </>
  );
};

export default Home;
