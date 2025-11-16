import React, { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import "../auth.css";
import toast from "react-hot-toast";
import apiClient from "../../../api/clientAppi";

const RegisterPage = () => {
  const [state, setState] = useState({
    username: "",
    email: "",
    password: "",
    confirmPassword: ""
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const navigate = useNavigate();

  const handleChange = (evt) => {
    setState({ ...state, [evt.target.name]: evt.target.value });
  };

  const handleSubmit = async (evt) => {
    evt.preventDefault();
    setError("");

    if (state.password !== state.confirmPassword) {
      setError("Password và Confirm Password không khớp!");
      return;
    }

    setLoading(true);

    try {
      const res = await apiClient.post("auth/register", state);

      const data = res.data;
      console.log("Register success:", data);

      if (data.user) {
        localStorage.setItem("token", data.user.firebaseToken);
        toast.success("Đăng ký thành công!");
        navigate("/home");
      } else {
        alert("Đăng ký thành công nhưng không nhận được token.");
      }

      setState({ username: "", email: "", password: "", confirmPassword: "" });

    } catch (err) {
      if (err.response) {
        setError(err.response.data.message || "Đăng ký thất bại!");
      } else if (err.request) {
        setError("Không thể kết nối tới máy chủ. Vui lòng thử lại.");
      } else {
        setError("Đã xảy ra lỗi. Vui lòng thử lại.");
      }
      console.error("Register error:", err);
    }

    setLoading(false);
  };

  return (
    <div className="form-container sign-up-container">
      <form onSubmit={handleSubmit}>
        <h1>Create Account</h1>
        <br /><br />

        <input type="text" name="username" placeholder="Username"
          value={state.username} onChange={handleChange} />

        <input type="email" name="email" placeholder="Email"
          value={state.email} onChange={handleChange} />

        <input type="password" name="password" placeholder="Password"
          value={state.password} onChange={handleChange} />

        <input type="password" name="confirmPassword" placeholder="Confirm Password"
          value={state.confirmPassword} onChange={handleChange} />

        {error && <p style={{ color: "red" }}>{error}</p>}

        <br /><br />
        <button type="submit" disabled={loading}>
          {loading ? "Signing Up..." : "Sign Up"}
        </button>
      </form>
    </div>
  );
};

export default RegisterPage;
