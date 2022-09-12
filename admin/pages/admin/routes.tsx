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
  MultiSelect,
} from "@mantine/core";
import { useForm } from "@mantine/form";
import { showNotification, updateNotification } from "@mantine/notifications";
import { IconCheck } from "@tabler/icons";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { addDoc, collection, getDocs } from "firebase/firestore";
import React, { useState } from "react";
import TableHelper from "../../src/components/TableHelper";
import { database } from "../../src/lib";

export const times = [
  "7:00 AM",
  "8:00 AM",
  "9:00 AM",
  "10:00 AM",
  "11:00 AM",
  "12:00 PM",
  "1:00 PM",
  "2:00 PM",
  "3:00 PM",
  "4:00 PM",
  "5:00 PM",
  "6:00 PM",
  "7:00 PM",
  "8:00 PM",
];
export const places = [
  "Amborkhana",
  "Eidgah",
  "TB GATE",
  "Tilagor",
  "Khadim",
  "Shahporan",
  "Bondor",
  "Noyashorok",
  "Kumarpara",
  "Naiorpul",
  "Zindabazar",
  "Chowhatta",
  "Rikabibazar",
  "Taltoala",
  "Jitu miar point",
  "Modina Market",
  "Pathantula",
  "Shubidbazar",
  "Akhali ghat",
  "Varsity gate",
  "Lakkatura",
  "Uposhohor",
  "campus",
];
export const routeDbInstance = collection(database, "routes");
export const getRoutes = () => {
  return getDocs(routeDbInstance).then((data) => {
    const dt = data.docs.map((item) => {
      return { ...item.data(), id: item.id };
    });
    return dt;
  });
};
const Routes = () => {
  const { data, isLoading, isError } = useQuery(["routes"], getRoutes);
  console.log({ data });

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
      {data && <TableHelper type="routes" data={data} />}
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
        <MultiSelect
          {...form.getInputProps("label")}
          data={places}
          label="Route"
          searchable
          placeholder="Pick all that you like"
        />
        <Select
          label="Start time"
          placeholder="Pick time"
          data={times}
          {...form.getInputProps("startTime")}
        />
        <Group position="right" mt="md">
          <Button type="submit">Submit</Button>
        </Group>
      </form>
    </Box>
  );
};
