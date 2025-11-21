
import SearchBar from "../../layouts/SearchBar";
import ShiftTable from "../../components/ShiftTable";

const Shift = () => {
  return (
    <>
      <header className="header">
        <h1>Ca làm</h1>
        <SearchBar />
      </header>
      <ShiftTable />
    </>
  );
};

export default Shift;
