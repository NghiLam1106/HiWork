import { useEffect, useState } from "react";
import apiClient from "../../../api/clientAppi"; // import api client
import EmployeeTable from "../../../components/EmployeeTable";
import SearchBar from "../../../layouts/SearchBar";
import "./homePage.css";

const Home = () => {

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
