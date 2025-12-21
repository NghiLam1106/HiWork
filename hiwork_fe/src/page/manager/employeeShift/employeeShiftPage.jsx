
import EmployeeShiftTable from "../../../components/EmployeeShiftTable";
import SearchBar from "../../../layouts/SearchBar";
import "../user/userPage.css";

const EmployeeShiftPage = () => {
  return (
    <>
      <header className="header">
        <h1></h1>
        <SearchBar />
      </header>
      <EmployeeShiftTable />
    </>
  );
};

export default EmployeeShiftPage;
