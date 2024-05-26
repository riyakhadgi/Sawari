import React, { useEffect, useState } from 'react';
import { Box, Button, Typography } from '@mui/material';
import Table from './admintable.jsx';
import axios from 'axios';
import { admincolumn } from '../assets/Coloums'; // This import seems unused
import Popup from './Addadmin.jsx'; 
// Define the columns for the table


export default function Admins() {
const [admins, setAdmins] = useState([]);
const [open, setOpen] = useState(false); 
const handleclose = () => {
    setOpen(false);
};
useEffect(() => {
    // Fetch data from the API when the component mounts
    axios.get('http://127.0.0.1:8000/showadmin/')
    .then((res) => {
        console.log(res.data);
        setAdmins(res.data);
        })
        .catch((error) => {
        console.error('Error fetching admin data:', error);
        });
    }, []);

    return (
    <Box sx={{
        padding: "2rem",
    }}>
        
        <Box display={'flex'}>
        <Typography variant="h1">Admins</Typography>
        <Button variant="contained" color="secondary" sx={{ marginLeft: 'auto' }}  onClick={() => setOpen(!open)}>Add Admin</Button>
        <Popup open={open} close={handleclose} title="Add Admin" />
        </Box>
        <Table data={admins} columns={admincolumn} />
    </Box>
    );
}
