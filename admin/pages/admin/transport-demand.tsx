import {
  Button,
  Group,
  Header,
  Modal,
  Select,
  Table,
  Text,
} from "@mantine/core";
import { showNotification, updateNotification } from "@mantine/notifications";
import { Autocomplete, TextField } from "@mui/material";
import { IconCheck } from "@tabler/icons";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { addDoc, collection, getDocs } from "firebase/firestore";
import React, { useEffect, useState } from "react";
import { getBuses } from "../../src/components/BusInventoryForm";
import { database } from "../../src/lib";
import { getRoutes, times } from "./routes";

const transportAllocationDbInstance = collection(
  database,
  "transportAllocation"
);
export const getAllocations = () => {
  return getDocs(transportAllocationDbInstance).then((data) => {
    const dt = data.docs.map((item) => {
      return { ...item.data(), id: item.id };
    });
    return dt;
  });
};
const TransportDemand = () => {
  const [route, setRoute] = useState();
  const [time, setTime] = useState<string | null>(null);

  const [bus, setBus] = useState([]);

  const [type, setType] = useState<string | null>(null);

  const { data: routes } = useQuery(["routes"], getRoutes);
  const { data: buses } = useQuery(["bus-inventory"], getBuses);
  const [open, setOpen] = useState(false);
  const queryClient = useQueryClient();
  const [structuredData, setStructuedData] = useState([]);
  const { data } = useQuery(["transportAllocation"], getAllocations);
  console.log({ data });
  console.log({ structuredData });

  useEffect(() => {
    const dt = data?.map((dt) => {
      return {
        routeLabel: dt.route.label.join("-"),
        buses: dt.bus.map((b) => b.codeName).join(","),
        time: dt.time,
        user_type: dt.type,
      };
    });
    setStructuedData(dt);
  }, [data]);

  const handleSubmit = (val: any) => {
    showNotification({
      id: "adding-bus",
      loading: true,
      title: "Allocating...",
      message: "Please wait",
      autoClose: false,
      disallowClose: true,
    });
    addDoc(transportAllocationDbInstance, {
      time,
      route,
      bus,
      type,
    }).then(() => {
      queryClient.invalidateQueries(["transportAllocation"]);
      updateNotification({
        id: "adding-bus",
        color: "teal",
        title: "Bus was added",
        message: "Data was added",
        icon: <IconCheck />,
        autoClose: 2000,
      });
    });
    setOpen(false);
  };

  if (!routes && !buses) return null;
  return (
    <>
      <Header height={60} mb={20} className="flex">
        <Text
          component="span"
          align="center"
          variant="gradient"
          gradient={{ from: "indigo", to: "cyan", deg: 45 }}
          size="xl"
          weight={700}
        >
          Transport Demand Allocation
        </Text>
        <Button onClick={() => setOpen(true)}>Allocate Transport</Button>
      </Header>
      {structuredData && <Helper data={structuredData} />}
      <Modal
        opened={open}
        onClose={() => setOpen(false)}
        title="Allocate Transport"
      >
        <Select
          value={time}
          onChange={setTime}
          label="Select a timeslot"
          placeholder="Pick timeslot"
          data={times}
        />
        <Autocomplete
          value={route}
          onChange={(event: any, newValue: string | null) => {
            setRoute(newValue);
          }}
          id="controllable-states-demo"
          options={routes?.filter((r) => r.startTime === time)}
          getOptionLabel={(option) => option.label?.join("-")}
          renderInput={(params) => (
            <TextField
              {...params}
              variant="standard"
              label="Pick route"
              placeholder="Favorites"
            />
          )}
          disableClearable
          style={{
            width: "100%",
            marginTop: "2px",
          }}
        />

        <Autocomplete
          multiple
          value={bus}
          onChange={(event, newValue) => {
            setBus(newValue);
          }}
          on
          id="tags-standard"
          options={buses}
          getOptionLabel={(option) => option.codeName}
          renderInput={(params) => (
            <TextField
              {...params}
              variant="standard"
              label="Select bus(es)"
              placeholder="Favorites"
            />
          )}
        />
        <Select
          value={type}
          onChange={setType}
          label="Select type of consumer"
          placeholder="Pick consumer"
          data={["Student", "Teacher", "Staff or Officials", "Others"]}
        />

        <Group position="right" mt="md">
          <Button onClick={handleSubmit}>Submit</Button>
        </Group>
      </Modal>
    </>
  );
};

export default TransportDemand;

const Helper = ({ data }: any) => {
  const getData = (data: any) => {
    return data.map((element: any, ind: Number) => (
      <tr key={ind}>
        <td>{element.routeLabel}</td>
        <td>{element.buses}</td>
        <td>{element.time}</td>
        <td>{element.user_type}</td>
      </tr>
    ));
  };
  const getHeader = () => {
    return (
      <tr>
        <th>Route Label</th>
        <th>{"Allocated bus(es)"}</th>
        <th>time</th>
        <th>user type</th>
      </tr>
    );
  };

  return (
    <Table horizontalSpacing="xl" verticalSpacing="xl" fontSize="lg">
      <thead>{getHeader()}</thead>
      <tbody>{getData(data)}</tbody>
    </Table>
  );
};
