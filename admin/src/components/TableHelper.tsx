import {
  Box,
  Divider,
  Modal,
  Select,
  Table,
  TextInput,
  Text,
  Button,
  Group,
  MultiSelect,
} from "@mantine/core";
import {
  doc,
  getDoc,
  getDocs,
  collection,
  updateDoc,
  deleteDoc,
} from "firebase/firestore";
import { database } from "../lib";
import { useQueryClient } from "@tanstack/react-query";
import React, { useState } from "react";
import { IconCheck, IconEdit, IconTrash } from "@tabler/icons";
import { showNotification, updateNotification } from "@mantine/notifications";
import { places } from "../../pages/admin/routes";

const TableHelper = ({ type = "bus-inventory", data }: any) => {
  const queryClient = useQueryClient();
  const [editing, setEditing] = useState(false);
  const [selected, setSelected] = useState({});

  const getBusInventory = (data: any) => {
    return data.map((element: any) => (
      <tr key={element.id}>
        <td>{element.lisenseNumber}</td>
        <td>{element.codeName}</td>
        <td>{element.capacity}</td>
        <td>{element.status}</td>
        <td>{element.driverName}</td>
        <td>{element.contactNumber}</td>
        <td>
          <IconEdit
            onClick={() => {
              setSelected(element);
              setEditing(true);
            }}
            style={{
              cursor: "pointer",
            }}
          />
        </td>
        <td>
          <IconTrash
            onClick={() => {
              const collectionById = doc(database, type, element.id);
              deleteDoc(collectionById).then(() => {
                queryClient.invalidateQueries([type]);
              });
            }}
            style={{
              cursor: "pointer",
            }}
          />
        </td>
      </tr>
    ));
  };
  const getRoutes = (data: any) => {
    return data.map((element: any) => (
      <tr key={element.id}>
        <td>{element.routeNumber}</td>
        <td>{element.label.join("-")}</td>
        <td>{element.startTime}</td>
        <td>
          <IconEdit
            onClick={() => {
              setSelected(element);
              setEditing(true);
            }}
            style={{
              cursor: "pointer",
            }}
          />
        </td>
        <td>
          <IconTrash
            onClick={() => {
              const collectionById = doc(database, type, element.id);
              deleteDoc(collectionById).then(() => {
                queryClient.invalidateQueries([type]);
              });
            }}
            style={{
              cursor: "pointer",
            }}
          />
        </td>
      </tr>
    ));
  };
  const getBusInventoryHeader = () => {
    return (
      <tr>
        <th>Lisence number </th>
        <th>Code name</th>
        <th>Capacity</th>
        <th>Status</th>
        <th>Driver Name</th>
        <th>Contact Number</th>
        <th></th>
        <th></th>
      </tr>
    );
  };
  const getRoutesHeader = () => {
    return (
      <tr>
        <th>Route number </th>
        <th>Route name</th>
        <th>Start time</th>

        <th></th>
        <th></th>
      </tr>
    );
  };

  console.log({ data });
  const getRows = (type: any, data: any) => {
    switch (type) {
      case "bus-inventory":
        return getBusInventory(data);
      case "routes":
        return getRoutes(data);
    }
  };
  const getRowsHeader = (type: any) => {
    switch (type) {
      case "bus-inventory":
        return getBusInventoryHeader();
      case "routes":
        return getRoutesHeader();
    }
  };

  const rows = getRows(type, data);
  const rowsHeader = getRowsHeader(type);

  return (
    <>
      {" "}
      <Table horizontalSpacing="xl" verticalSpacing="xl" fontSize="lg">
        <thead>{rowsHeader}</thead>
        <tbody>{rows}</tbody>
      </Table>
      <Modal opened={editing} onClose={() => setEditing(false)} title="Add Bus">
        {/* Modal content */}
        {type === "bus-inventory" && (
          <BusForm data={selected} setSelected={setSelected} type={type} />
        )}
        {type === "routes" && (
          <RouteForm data={selected} setSelected={setSelected} type={type} />
        )}
      </Modal>
    </>
  );
};

export default TableHelper;

const BusForm = ({ data, setSelected, type }: any) => {
  const queryClient = useQueryClient();
  const [state, setState] = useState(data);

  const handleSubmit = (e: any) => {
    e.preventDefault();
    console.log({ data });
    const collectionById = doc(database, type, data.id);
    showNotification({
      id: "editing-bus",
      loading: true,
      title: "Editing...",
      message: "Please wait",
      autoClose: false,
      disallowClose: true,
    });

    updateDoc(collectionById, {
      lisenseNumber: data.lisenseNumber,
      codeName: data.codeName,
      capacity: data.capacity,
      driverName: data.driverName,
      contactNumber: data.contactNumber,
      status: data.status,
    }).then(() => {
      queryClient.invalidateQueries([type]);
      updateNotification({
        id: "editing-bus",
        color: "teal",
        title: "Bus was added",
        message: "Data was added",
        icon: <IconCheck />,
        autoClose: 2000,
      });
    });
  };
  return (
    <Box sx={{ maxWidth: 300 }} mx="auto">
      <TextInput
        withAsterisk
        label="lisense number"
        placeholder="lisense number"
        value={data.lisenseNumber}
        onChange={(e) => {
          setSelected((prev: any) => ({
            ...prev,
            lisenseNumber: e.currentTarget?.value,
          }));
        }}
      />
      <TextInput
        withAsterisk
        label="code name"
        placeholder="code name"
        value={data.codeName}
        onChange={(e) => {
          setSelected((prev: any) => ({
            ...prev,
            codeName: e.currentTarget?.value,
          }));
        }}
      />
      <TextInput
        withAsterisk
        label="capacity"
        placeholder="capacity"
        value={data.capacity}
        onChange={(e) => {
          setSelected((prev: any) => ({
            ...prev,
            capacity: e.currentTarget?.value,
          }));
        }}
      />
      <Select
        label="Status"
        placeholder="Pick one"
        data={["on service", "maintanance"]}
        value={data.status}
        onChange={(e) => {
          setSelected((prev: any) => ({
            ...prev,
            status: e,
          }));
        }}
      />
      <Text mt={20}>Driver Info</Text>
      <Divider />
      <TextInput
        withAsterisk
        label="driver name"
        placeholder="driver name"
        value={data.driverName}
        onChange={(e) => {
          setSelected((prev: any) => ({
            ...prev,
            driverName: e.currentTarget?.value,
          }));
        }}
      />
      <TextInput
        withAsterisk
        label="contact nummber"
        placeholder="contact nummber"
        value={data.contactNumber}
        onChange={(e) => {
          setSelected((prev: any) => ({
            ...prev,
            contactNumber: e.currentTarget?.value,
          }));
        }}
      />

      <Group position="right" mt="md">
        <Button onClick={handleSubmit}>Submit</Button>
      </Group>
    </Box>
  );
};

const RouteForm = ({ data, setSelected, type }: any) => {
  const queryClient = useQueryClient();
  const [state, setState] = useState(data);

  const handleSubmit = (e: any) => {
    e.preventDefault();
    console.log({ data });
    const collectionById = doc(database, type, data.id);
    showNotification({
      id: "editing-routes",
      loading: true,
      title: "Editing...",
      message: "Please wait",
      autoClose: false,
      disallowClose: true,
    });

    updateDoc(collectionById, {
      routeNumber: data.routeNumber,
      label: data.label,
      startTime: data.startTime,
    }).then(() => {
      queryClient.invalidateQueries([type]);
      updateNotification({
        id: "editing-routes",
        color: "teal",
        title: "Bus was added",
        message: "Data was added",
        icon: <IconCheck />,
        autoClose: 2000,
      });
    });
  };
  return (
    <Box sx={{ maxWidth: 300 }} mx="auto">
      <TextInput
        withAsterisk
        label="Route number"
        placeholder="Route number"
        value={data.routeNumber}
        onChange={(e) => {
          setSelected((prev: any) => ({
            ...prev,
            routeNumber: e.currentTarget?.value,
          }));
        }}
      />
      <MultiSelect
        value={data.label}
        onChange={(val) => {
          setSelected((prev: any) => ({
            ...prev,
            label: val,
          }));
        }}
        data={places}
        label="Route"
        searchable
        placeholder="Pick "
      />
      <TextInput
        withAsterisk
        label="start time"
        placeholder="start time"
        value={data.startTime}
        onChange={(e) => {
          setSelected((prev: any) => ({
            ...prev,
            capacity: e.currentTarget?.value,
          }));
        }}
      />

      <Group position="right" mt="md">
        <Button onClick={handleSubmit}>Submit</Button>
      </Group>
    </Box>
  );
};
