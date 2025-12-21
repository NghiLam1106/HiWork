
import AttendanceTable from "../../../components/AttendanceTable";
import SearchBar from "../../../layouts/SearchBar";
import "../user/userPage.css";

const AttendancePage = () => {
  return (
    <>
      <header className="header">
        <h1></h1>
        <SearchBar />
      </header>
      <AttendanceTable />
    </>
  );
};

export default AttendancePage;
