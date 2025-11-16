import React, { useState } from "react";
import RegisterPage from "./register/RegisterPage";
import LoginPage from "./login/loginPage";
import "./Auth.css"; // chứa CSS chung container + overlay

const Auth = () => {
  const [type, setType] = useState("signIn");

  const toggleType = (text) => {
    if (text !== type) setType(text);
  };

  return (
    <div className="auth-app">
      <div className={`container ${type === "signUp" ? "right-panel-active" : ""}`}>
        <LoginPage />
        <RegisterPage />
        <div className="overlay-container">
          <div className="overlay">
            <div className="overlay-panel overlay-left">
              <h1>Welcome Back!</h1>
              <p>To keep connected with us, please login with your personal info</p>
              <button className="ghost" onClick={() => toggleType("signIn")}>
                Sign In
              </button>
            </div>
            <div className="overlay-panel overlay-right">
              <h1>Hello, Friend!</h1>
              <p>Enter your personal details and start your journey with us</p>
              <button className="ghost" onClick={() => toggleType("signUp")}>
                Sign Up
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Auth;
