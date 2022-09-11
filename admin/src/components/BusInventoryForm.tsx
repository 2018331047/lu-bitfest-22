import {
  TextInput,
  Checkbox,
  Button,
  Group,
  Box,
  Text,
  Divider,
  Select,
  Header,
  Modal,
} from "@mantine/core";
import { useForm } from "@mantine/form";
import { app, database } from "../lib";
import { collection, addDoc, getDocs } from "firebase/firestore";
import { useEffect, useState } from "react";
import { showNotification, updateNotification } from "@mantine/notifications";
import { IconCheck } from "@tabler/icons";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import TableHelper from "./TableHelper";

export const busInventoryDbInstance = collection(database, "bus-inventory");
export const getBuses = () => {
  return getDocs(busInventoryDbInstance).then((data) => {
    const dt = data.docs.map((item) => {
      return { ...item.data(), id: item.id };
    });
    return dt;
  });
};
export default function BusInventoryForm() {
  const form = useForm({
    initialValues: {
      lisenseNumber: "",
      codeName: "",
      capacity: 50,
      driverName: "",
      contactNumber: "",
      status: "",
    },

    validate: {},
  });

  const queryClient = useQueryClient();
  const [open, setOpen] = useState(false);
  const { data, isLoading, isError } = useQuery(["bus-inventory"], getBuses);
  console.log({ data });

  const handleSubmit = (val: any) => {
    showNotification({
      id: "adding-bus",
      loading: true,
      title: "Adding...",
      message: "Please wait",
      autoClose: false,
      disallowClose: true,
    });
    addDoc(busInventoryDbInstance, {
      lisenseNumber: val.lisenseNumber,
      codeName: val.codeName,
      capacity: val.capacity,
      driverName: val.driverName,
      contactNumber: val.contactNumber,
      status: val.status,
    }).then(() => {
      queryClient.invalidateQueries(["bus-inventory"]);
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
          Bus inventory
        </Text>
        <Button onClick={() => setOpen(true)}>Add Bus</Button>
      </Header>
      <Modal opened={open} onClose={() => setOpen(false)} title="Add Bus">
        {/* Modal content */}
        <FormBox form={form} handleSubmit={handleSubmit} />
      </Modal>
      {data && <TableHelper data={data} />}
    </>
  );
}

const FormBox = ({ form, handleSubmit }: any) => {
  return (
    <Box sx={{ maxWidth: 300 }} mx="auto">
      <form onSubmit={form.onSubmit(handleSubmit)}>
        <TextInput
          withAsterisk
          label="lisense number"
          placeholder="lisense number"
          {...form.getInputProps("lisenseNumber")}
          requiered
        />
        <TextInput
          withAsterisk
          label="code name"
          placeholder="code name"
          {...form.getInputProps("codeName")}
          requiered
        />
        <TextInput
          withAsterisk
          label="capacity"
          placeholder="capacity"
          {...form.getInputProps("capacity")}
          requiered
        />
        <Select
          label="Status"
          placeholder="Pick one"
          data={["on service", "maintanance"]}
          {...form.getInputProps("status")}
        />
        <Text mt={20}>Driver Info</Text>
        <Divider />
        <TextInput
          withAsterisk
          label="driver name"
          placeholder="driver name"
          {...form.getInputProps("driverName")}
          requiered
        />
        <TextInput
          withAsterisk
          label="contact nummber"
          placeholder="contact nummber"
          {...form.getInputProps("contactNumber")}
          requiered
        />

        <Group position="right" mt="md">
          <Button type="submit">Submit</Button>
        </Group>
      </form>
    </Box>
  );
};
