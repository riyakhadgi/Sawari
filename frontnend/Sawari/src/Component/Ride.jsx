import { React, useEffect, useState } from "react";
import { Box, Typography } from "@mui/material";
import Table from "./Table.jsx";
import axios from "axios";
import { acceptedcolumn, ridecolumn } from "../assets/Coloums.js";

export default function Ride() {
  const [riderequested, setRideRequests] = useState([]);
  const [acceptedride, setAcceptedRides] = useState([]);
  useEffect(() => {
    axios.get("http://127.0.0.1:8000/book/getallrides/").then((res) => {
      if (res.data.success) {
        const rideRequests = res.data.data.ride_requests.map((ride) => ({
          ...ride,
          type: "ride_request",
        }));
        const acceptedRides = res.data.data.accepted_requests.map((ride) => ({
          ...ride,
          type: "accepted_ride",
        }));

        // Update state with separate arrays for each type of ride
        setRideRequests(rideRequests);
        console.log(acceptedRides);
        setAcceptedRides(acceptedRides);
      } else {
        console.error("Failed to fetch data");
      }
    });
  }, []);
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
    <Box sx={{ padding: "2rem" }}>
    <Box>
      <Typography variant="h1">Ride</Typography>
      <Box sx={{ height: 300, overflow: 'auto' }}>
        <Table columns={ridecolumn} data={riderequested} />
      </Box>
    </Box>
      <Box
        sx={{
          display: "flex",
          flexDirection: "rows",
          marginTop: "1rem",
          gap: "2rem",
        }}
      >
        <Box sx={{ flex: 1 }}>
          <Typography variant="h1">Accepted Ride</Typography>
          <Box sx={{ height: 300, overflow: 'auto' }}>
            <Table columns={acceptedcolumn} data={acceptedride} />
          </Box>
        </Box>
      </Box>
    </Box>
  );
}
