
import ShiftTable from "../../../components/ShiftTable";
import SearchBar from "../../../layouts/SearchBar";

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
