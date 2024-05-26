import {React, useEffect} from "react";
import axios from "axios";
import { useState } from "react";
import { Box, Typography } from "@mui/material";
import Table from "./Table";
import { prebookcolumn } from "../assets/Coloums.js";
export default function Drivers() {
    const [prebooks, setPrebooks] = useState([]); // This line seems unused
    useEffect(() => {
        axios.get("http://127.0.0.1:8000/book/showprebooking/")
        .then((res) => {
            if(res.data.success){
                console.log(res.data.data);
                setPrebooks(res.data.data);
            }
            else{
                console.error("Failed to fetch data");
            }
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
            <Typography variant="h1">Prebookings</Typography>
            <Table data={prebooks} columns={prebookcolumn} />
        </Box>
    )
}