import {
  Header,
  Button,
  Text,
  Modal,
  Box,
  Divider,
  Group,
  Select,
  TextInput,
} from "@mantine/core";
import { useForm } from "@mantine/form";
import { showNotification, updateNotification } from "@mantine/notifications";
import { IconCheck } from "@tabler/icons";
import { useQueryClient } from "@tanstack/react-query";
import { addDoc, collection } from "firebase/firestore";
import React, { useState } from "react";
import { database } from "../../src/lib";

export const routeDbInstance = collection(database, "routes");
const Routes = () => {
  const queryClient = useQueryClient();
  const [open, setOpen] = useState(false);
  const form = useForm({
    initialValues: {
      routeNumber: "",
      label: "",
      startTime: "",
    },

    validate: {},
  });
  const handleSubmit = (val: any) => {
    showNotification({
      id: "adding-bus",
      loading: true,
      title: "Adding...",
      message: "Please wait",
      autoClose: false,
      disallowClose: true,
    });
    addDoc(routeDbInstance, {
      routeNumber: val.routeNumber,
      label: val.label,
      startTime: val.startTime,
    }).then(() => {
      queryClient.invalidateQueries(["routes"]);
      updateNotification({
        id: "adding-bus",
        color: "teal",
        title: "Route was added",
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
          Routes
        </Text>
        <Button onClick={() => setOpen(true)}>Add Route</Button>
      </Header>
      <Modal opened={open} onClose={() => setOpen(false)} title="Add Bus">
        {/* Modal content */}
        <FormBox form={form} handleSubmit={handleSubmit} />
      </Modal>
    </>
  );
};

export default Routes;

const FormBox = ({ form, handleSubmit }: any) => {
  return (
    <Box sx={{ maxWidth: 300 }} mx="auto">
      <form onSubmit={form.onSubmit(handleSubmit)}>
        <TextInput
          withAsterisk
          label="route number"
          placeholder="route number"
          {...form.getInputProps("routeNumber")}
          requiered
        />
        <TextInput
          withAsterisk
          label="Route name"
          placeholder="Route name"
          {...form.getInputProps("label")}
          requiered
        />
        <Select
          label="Start time"
          placeholder="Pick time"
          data={[
            "7 am",
            "8 am",
            "9 am",
            "10 am",
            "11 am",
            "12 pm",
            "1 pm",
            "2 pm",
            "3 pm",
            "4 pm",
            "5 pm",
            "6 pm",
            "7 pm",
            "8 pm",
          ]}
          {...form.getInputProps("startTime")}
        />
        <Group position="right" mt="md">
          <Button type="submit">Submit</Button>
        </Group>
      </form>
    </Box>
  );
};
