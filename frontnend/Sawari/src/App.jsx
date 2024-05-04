import { useState } from 'react'
import './App.css'
import { Routes, Route, useLocation } from "react-router-dom";
import { CssBaseline, ThemeProvider } from "@mui/material";
import { ColorModeContext, useMode } from "./Theme";
import Login from './Component/Login.jsx'
import Dashboard from './Component/Dashboard.jsx'
import Sidebar from './Component/Sidebar.jsx';
import Ride from './Component/Ride.jsx';
import Users from './Component/Users.jsx';
import Admins from './Component/Admins.jsx';
import Drivers from './Component/Drivers.jsx';
import Prebooking from './Component/Prebooking.jsx';


function App() {
  const [theme, colorMode] = useMode();
  const location = useLocation();
  const LoginPage = location.pathname === "/";

  return (
    <ColorModeContext.Provider value={colorMode}>
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <div className="app">
        {!LoginPage   && <Sidebar />}
        <main className="content">
          <Routes>
          <Route path="/" element={<Login />} />
          <Route path="/dashboard" element={<Dashboard/>} />
          <Route path="/ride" element={<Ride/>} />
          <Route path="/users" element={<Users/>} />
          <Route path= "/admins" element={<Admins/>} />	
          <Route path="/drivers" element={<Drivers/>} />
          <Route path="/prebooking" element={<Prebooking/>} />
          </Routes>
        </main>
      </div>
    </ThemeProvider>
  </ColorModeContext.Provider>
  )
}

export default App
