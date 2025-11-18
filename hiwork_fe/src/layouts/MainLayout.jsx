
import React from "react";
import Sidebar from "./Sidebar";;
import "./css/Sidebar.css";

export default function AdminLayout({ children }) {
  return (
    <div className="admin-container">
      <Sidebar />
        <main className="main-content">{children}</main>
    </div>
  );
}
