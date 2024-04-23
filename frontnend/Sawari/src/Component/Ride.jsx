import {React, useEffect,useState} from 'react'
import {Box, Typography} from '@mui/material'
import Table from './Table.jsx'
import axios from 'axios'

export default function Ride() {
    const [data, setData] = useState([]);
    useEffect(() => {  
        axios.get("http://127.0.0.1:8000/book/getallrides/")
        .then((res)=>{
            if (res.data.success) {
                const rideRequests = res.data.data.ride_requests.map(ride => ({ ...ride, type: 'ride_request' }));
                const acceptedRides = res.data.data.accepted_requests.map(ride => ({ ...ride, type: 'accepted_ride' }));
                const canceledRides = res.data.data.canceled_requests.map(ride => ({ ...ride, type: 'canceled_ride' }));

                // Merge and deduplicate rides based on a unique identifier (e.g., ride ID)
                const mergedRides = [...rideRequests, ...acceptedRides, ...canceledRides].reduce((acc, current) => {
                    const x = acc.find(item => item.id === current.id);
                    if (!x) {
                        return acc.concat([current]);
                    } else {
                        return acc;
                    }
                }, []);
                    
                console.log(mergedRides);
                setData(mergedRides);
            } else {
                console.error('Failed to fetch data');
            }
        })
    }, [])
    const columns = [
        { field: "id", headerName: "ID" },
        {
            field: "username",
            headerName: "User",
            editable: true,
        },
        {
            field: "pickup",
            headerName: "Pickup Location",
            editable: true,
        },
        {
            field: "drop",
            headerName: "Drop Location",
            editable: true,
        },
        {
            field: "distance",
            headerName: "Distance",
            editable: true,
        },
        {
            field: "fare",
            headerName: "Fare",
            editable: true,
        },
       
        {
            field: "driver",
            headerName: "Driver",
            editable: true,
        },
        {
            field: "status",
            headerName: "Status",
            editable: true,
        },
      ];
    return (
        <Box >
            <Typography variant="h1">Ride</Typography>
            <Table columns={columns} data={data} />
        </Box>
    )
}
