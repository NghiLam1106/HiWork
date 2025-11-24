// src/components/common/SearchBar.js
import React from 'react';
import { FaSearch } from "react-icons/fa";

const SearchBar = ({ placeholder = "Tìm kiếm...", value, onChange, width = "250px" }) => {
  return (
    <form className="position-relative" onSubmit={(e) => e.preventDefault()}>
      <div className="input-group">
        {/* Icon: Nền xám, bo tròn trái */}
        <span
          className="input-group-text bg-light border-0 rounded-start-pill ps-3 text-muted"
          style={{ cursor: "pointer" }}
        >
          <FaSearch />
        </span>

        {/* Input: Nền xám, bo tròn phải, không viền */}
        <input
          type="search"
          className="form-control bg-light border-0 rounded-end-pill shadow-none"
          placeholder={placeholder}
          aria-label="Search"
          value={value} // Nhận value từ cha
          onChange={onChange} // Báo sự kiện thay đổi về cha
          style={{ width: width }} // Có thể chỉnh độ rộng tùy ý
        />
      </div>
    </form>
  );
};

export default SearchBar;
