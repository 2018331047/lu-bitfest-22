import {
  Button,
  Group,
  Header,
  Modal,
  MultiSelect,
  NumberInput,
  Select,
  Text,
} from "@mantine/core";
import { showNotification, updateNotification } from "@mantine/notifications";
import { IconCheck } from "@tabler/icons";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { addDoc, collection, getDocs } from "firebase/firestore";
import React, { useState } from "react";
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
  const [route, setRoute] = useState<string | null>(null);
  const [time, setTime] = useState<string | null>(null);

  const [bus, setBus] = useState<string | null>(null);

  const [type, setType] = useState<string | null>(null);

  const { data: routes } = useQuery(["routes"], getRoutes);
  const { data: buses } = useQuery(["bus-inventory"], getBuses);
  const [open, setOpen] = useState(false);
  const queryClient = useQueryClient();
  const { data } = useQuery(["transportAllocation"], getAllocations);
  console.log({ data });

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
          Routes
        </Text>
        <Button onClick={() => setOpen(true)}>Allocate Transport</Button>
      </Header>
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
        <Select
          value={route}
          onChange={setRoute}
          label="Select route"
          placeholder="Pick Route"
          data={routes
            ?.map((r) => ({
              value: r.id,
              label: r.label.join("-"),
              time: r.startTime,
            }))
            .filter((f) => f.time === time)}
        />

        <MultiSelect
          value={bus}
          onChange={setBus}
          label="Allocate bus"
          placeholder="Bus"
          data={buses?.map((r) => ({
            value: r.id,
            label: r.codeName,
          }))}
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
