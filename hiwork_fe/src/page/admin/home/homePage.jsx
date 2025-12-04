import { useEffect, useState } from "react";
import apiClient from "../../../api/clientAppi"; // import api client
import EmployeeTable from "../../../components/EmployeeTable";
import SearchBar from "../../../layouts/SearchBar";
import "./homePage.css";

const Home = () => {
  const [positionCount, setPositionCount] = useState(0); // số lượng vị trí

  useEffect(() => {
    const fetchPositionCount = async () => {
      try {
        const res = await apiClient.get("/manager/positions?limit=1"); // lấy 1 item để đọc pagination
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

      <EmployeeTable />
    </>
  );
};

export default Home;
