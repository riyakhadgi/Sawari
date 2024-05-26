import { useState } from "react";

import { Box, Divider, IconButton, Typography, useTheme } from "@mui/material";
import { Sidebar, Menu, MenuItem } from "react-pro-sidebar";
import LogoutIcon from '@mui/icons-material/Logout';
import DirectionsCarOutlinedIcon from "@mui/icons-material/DirectionsCarOutlined";
import AdminPanelSettingsIcon from "@mui/icons-material/AdminPanelSettings";
import GroupIcon from '@mui/icons-material/Group';
import BookIcon from '@mui/icons-material/Book';
import PedalBikeIcon from '@mui/icons-material/PedalBike';
import { Link } from "react-router-dom";
import Cookie from "js-cookie";
import { tokens } from "../Theme";
import { useEffect } from "react";
import axios from "axios";

const Item = ({ title, to, icon, selected, setSelected }) => {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  return (
    <MenuItem
      component={<Link to={to} />}
      sx={{
        color: colors.grey[100],
      }}
      active={selected === title}
      icon={icon}
      onClick={() => setSelected(title)}
    >
      <Typography variant="h4">{title}</Typography>
    </MenuItem>
  );
};

const SideItem = ({ selected, setSelected }) => {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  return (
    <Box paddingLeft="10%" mt={6}>
      {/* <Item
        title="Dashboard"
        to="/restaurant/dashboard"
        icon={<HomeOutlinedIcon />}
        selected={selected}
        setSelected={setSelected}
      /> */}
            <Typography
        variant="h6"
        color={colors.grey[100]}
        sx={{ m: "15px 0 5px 20px" }}
      >
        Data
      </Typography>
      <Item
        title="Ride"
        to="/ride"
        icon={<DirectionsCarOutlinedIcon />}
        selected={selected}
        setSelected={setSelected}
      />
      <Item
        title="PreBooking"
        to="/prebooking"
        icon={<BookIcon />}
        selected={selected}
        setSelected={setSelected}
      />
      <Item
        title="Driver"
        to="/drivers"
        icon={<PedalBikeIcon/>}
        selected={selected}
        setSelected={setSelected}
      />
       <Item
        title="User"
        to="/users"
        icon={<GroupIcon/>}
        selected={selected}
        setSelected={setSelected}
      />
        <Item
        title="Admin"
        to="/admins"
        icon={<AdminPanelSettingsIcon/>}
        selected={selected}
        setSelected={setSelected}
      />
    </Box>
  );
};
export default function Menubar() {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  const [selected, setSelected] = useState("Ride");
  const [name, setName] = useState("");
  const handlelogout = () => {
		// clear the cookies
		const cookies = document.cookie.split(";").map((cookie) => cookie.trim());
		const tokenCookie = cookies.find((cookie) => cookie.startsWith("token="));
		if (tokenCookie) {
			document.cookie =
				"token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
		}
		window.location.href = "/";

	};
  useEffect(() => {
    // Extract token from cookies
    const cookies = document.cookie.split(";").map((cookie) => cookie.trim());
    const tokenCookie = cookies.find((cookie) => cookie.startsWith("token="));

    // Check if token exists
    if (tokenCookie) {
      const token = tokenCookie.split("=")[1];
      const data = JSON.parse(atob(token.split(".")[1]));
      setName(data.data.name);
    }
  }, []);
  return (
    <Sidebar
      backgroundColor={
        theme.palette.mode === "dark"
          ? colors.primary[800]
          : colors.blueAccent[500]
      }
    >
      <Menu
        menuItemStyles={{
          button: {
            "&:hover": {
              backgroundColor: "transparent",
              color: colors.blueAccent[500],
              color:
                theme.palette.mode === "dark"
                  ? colors.blueAccent[500]
                  : colors.grey[800],
            },
            "&:active": {
              backgroundColor: colors.blueAccent[400],
              color: colors.greenAccent[500],
            },
            "::after": {
              color: "red",
              backgroundColor: "red",
            },
          },
        }}
      >
       
      
          <Box textAlign="center" display="grid" gap={2}>

            <Typography variant="h2" fontWeight="bold" color={"white"}>
              Welcome back
            </Typography>
            <Typography variant="h4" fontWeight={"bold"} color={"white"}>
              {name}
            </Typography>
          </Box>
        
        <SideItem
        
            selected={selected}
            setSelected={setSelected}
          />
        <Divider />

        <MenuItem
          icon={<LogoutIcon />}
          sx={{
            color: colors.grey[100],
          }}

    
          onClick={handlelogout}
        >
          <Typography variant="h4">Logout</Typography>
        </MenuItem>

      </Menu>
    </Sidebar>
  );
}