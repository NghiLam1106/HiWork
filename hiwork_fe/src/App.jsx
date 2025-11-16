import { Toaster } from "react-hot-toast";
import AppRoutes from "./routes/appRoute";
import "./toast.css";

function App() {
  return (
    <>
      <Toaster
        position="top-right"
        reverseOrder={false}
        toastOptions={{
          className: "my-toast",
          duration: 4000,
          success: {
            duration: 3500,
            className: "my-toast my-toast-success",
          },
          error: {
            duration: 5000,
            className: "my-toast my-toast-error",
          },
        }}
      />
      <AppRoutes />

    </>
  );
}

export default App;
