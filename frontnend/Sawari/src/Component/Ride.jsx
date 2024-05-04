import { React, useEffect, useState } from "react";
import { Box, Typography } from "@mui/material";
import Table from "./Table.jsx";
import axios from "axios";
import { acceptedcolumn, ridecolumn } from "../assets/Coloums.js";

export default function Ride() {
  const [riderequested, setRideRequests] = useState([]);
  const [acceptedride, setAcceptedRides] = useState([]);
  const [cancelledride, setCanceledRides] = useState([]);
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
        const canceledRides = res.data.data.canceled_requests.map((ride) => ({
          ...ride,
          type: "canceled_ride",
        }));

        // Update state with separate arrays for each type of ride
        setRideRequests(rideRequests);
        console.log(acceptedRides[0]["ride"]);
        setAcceptedRides(acceptedRides);
        setCanceledRides(canceledRides);
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
    <Box
      sx={{
        padding: "2rem",
      }}
    >
      <Box>
        <Typography variant="h1">Ride</Typography>
        <Table columns={ridecolumn} data={riderequested} />
      </Box>
      <Box
        sx={{
          display: "flex",
          flexDirection: "rows",
          marginTop: "1rem",
          gap: "2rem",
        }}
      >
        <Box>
          <Typography variant="h1">Cancelled Ride</Typography>
          <Table columns={columns} data={cancelledride} />
        </Box>
        <Box>
          <Typography variant="h1">Accepted Ride</Typography>
          <Table columns={acceptedcolumn} data={acceptedride} />
        </Box>
      </Box>
    </Box>
  );
}
