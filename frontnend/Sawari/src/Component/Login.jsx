import {React, useEffect, useState } from 'react'
import { InputAdornment,
    Box,
    TextField,
    Button,
    IconButton,
    useTheme,
    FormControl,
    Typography,} from '@mui/material'
import { tokens } from "../Theme";
import VisibilityIcon from "@mui/icons-material/Visibility";
import VisibilityOffIcon from "@mui/icons-material/VisibilityOff";
import axios from "axios";
// import Cookies from "js-cookie";
import { useNavigate } from "react-router-dom";
function Login() {
    const theme = useTheme();
    const colors = tokens(theme.palette.mode);
    const navigate = useNavigate();
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [showPassword, setShowPassword] = useState(false);
    const setCookies = (name, value, days) => {
        var expires = "";
        if (days) {
          var date = new Date();
          date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
          expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
      };
    const handleTogglePassword = () => {
        setShowPassword((prevShowPassword) => !prevShowPassword);
      };
    const handlelogin=()=>{
        const postdata={
            username:username,
            password:password
        }
        axios.post("http://127.0.0.1:8000/adminlogin/",postdata)
        .then((res)=>{
          console.log(res)
            if(res.data.success){
                console.log(res.data.message)
                setCookies("token", res.data.message, 1);
                navigate("/ride");
            }
            else{
              alert("Invalid Credentials")
            }
        })
        .catch((err)=>{
            console.log(err)
        })
    }
  return (
    <Box
    sx={{
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        width: "100%",
        height: "100vh", 
      }} >

       <Box
        borderRadius=" "
        width="30rem"
        height="30rem"
        display="flex"
        alignItems="center"
        flexDirection="column"
        padding={3}
        backgroundColor={colors.primary[600]}
      >

        <Typography variant="h2" fontWeight="bold" color={"white"}>
            Welcome back
        </Typography>
        <Box p={2} mt={4}>
          <TextField
            margin="normal"
            variant="outlined"
            color="secondary"
            label="Username"
            type="text"
            fullWidth
            onChange={(e) => {
                setUsername(e.target.value);
            }}
          />
          <TextField
            margin="normal"
            color="secondary"
            type={showPassword ? "text" : "password"}
            label="Password"
            onChange={(e) => {
              setPassword(e.target.value);
            }}
            InputProps={{
              endAdornment: (
                <InputAdornment position="end">
                  <IconButton edge="end" onClick={handleTogglePassword}>
                    {showPassword ? <VisibilityIcon /> : <VisibilityOffIcon />}
                  </IconButton>
                </InputAdornment>
              ),
            }}
            fullWidth
          />
        </Box>
        <Button
          variant="contained"
          sx={{ backgroundColor: colors.blueAccent[700] }}
          size="large"
          onClick={handlelogin}
        >
          Login
        </Button>
        </Box>

    </Box>
  )
};

export default Login