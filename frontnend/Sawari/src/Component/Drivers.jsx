import { Typography,Box, Tab } from '@mui/material'
import {React, useEffect} from 'react'
import Table from './Table'
import { drivercolumn } from "../assets/Coloums.js";
import axios from 'axios'
import { useState } from 'react';


export default function Drivers() {
    const [drivers, setDrivers] = useState([]);
    useEffect(() => {
        axios.get("http://127.0.0.1:8000/showdriver/")
            .then((res) => {
                console.log(res.data);
                setDrivers(res.data);
            })
            .catch((error) => {
                console.error("Error fetching data: ", error);
            });
    }, []);
    return ( 
        <Box sx={
            {
                padding: "2rem",
            }
        }>
            <Typography variant="h1">Drivers</Typography>
            <Table data={drivers} columns={drivercolumn} />
        </Box>
    )
}