import axios from "axios";
import { useState } from "react";
import { useNavigate } from 'react-router-dom';
import toast from "react-hot-toast";
import "../auth.css";
import apiClient from "../../../api/clientAppi";

const LoginPage = () => {
  const [state, setState] = useState({ email: "", password: "" });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const navigate = useNavigate(); // Khởi tạo hook

  const handleChange = (evt) => {
    setState({ ...state, [evt.target.name]: evt.target.value });
  };

  const handleSubmit = async (evt) => {
    evt.preventDefault();
    setLoading(true);
    setError("");

    try {
      const res = await apiClient.post("auth/login", state);

      const data = res.data;

      if (data.user) {
        localStorage.setItem("token", data.user.firebaseToken);
        toast.success("Đăng nhập thành công!");
        navigate("/home");
      } else {
        alert("Đăng nhập thành công nhưng không nhận được token.");
      }

    } catch (err) {
      if (err.response) {
        setError(err.response.data.message || "Sai email hoặc mật khẩu!");
      } else if (err.request) {
        setError("Không thể kết nối tới máy chủ. Vui lòng thử lại.");
      } else {
        setError("Đã xảy ra lỗi. Vui lòng thử lại.");
      }
      console.error("Login error:", err);
    }

    setLoading(false);
  };

  return (
    <div className="form-container sign-in-container">
      <form onSubmit={handleSubmit}>
        <h1>Sign In</h1>
        <br/><br/><br/>
        <input type="email" name="email" placeholder="Email" value={state.email} onChange={handleChange} />
        <input type="password" name="password" placeholder="Password" value={state.password} onChange={handleChange} />
        {error && <p style={{ color: "red" }}>{error}</p>}
        <a href="#">Forgot your password?</a>
        <button type="submit" disabled={loading}>{loading ? "Signing In..." : "Sign In"}</button>
      </form>
    </div>
  );
};

export default LoginPage;
