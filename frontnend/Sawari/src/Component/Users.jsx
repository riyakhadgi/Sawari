import {React, useEffect} from 'react'
import { useState } from 'react';
import { Box, Typography } from '@mui/material';
import Table from './Table';
import { usercolumn } from "../assets/Coloums.js";
import axios from 'axios';


export default function Users() {
    const [users, setUsers] = useState([]);
    useEffect(() => {
        axios.get("http://127.0.0.1:8000/showuser/")
            .then((res) => {
                console.log(res.data);
                setUsers(res.data);
            })
            .catch((error) => {
                console.error("Error fetching data: ", error);
            });
    }, [])

    return (
        <Box sx={
            {
                padding: "2rem",
            }
        }>
            <Typography variant="h1">Users</Typography>
            <Table data={users} columns={usercolumn} />
        </Box>
    )
}