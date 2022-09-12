import {
  TextInput,
  Checkbox,
  Button,
  Group,
  Box,
  Header,
  Text,
} from "@mantine/core";
import { useForm } from "@mantine/form";
import { showNotification, updateNotification } from "@mantine/notifications";
import { useQueryClient } from "@tanstack/react-query";
import { addDoc, collection } from "firebase/firestore";
import Link from "next/link";
import { useRouter } from "next/router";
import { database } from "../lib";

export const userDbInstance = collection(database, "admin");
export default function SignUpForm() {
  const router = useRouter();
  const form = useForm({
    initialValues: {
      fullName: "",
      contactNumber: "",
    },

    validate: {
      contactNumber: (value) =>
        /^(?:(?:\+|00)88|01)?\d{11}\r?$/.test(value) ? null : "Invalid number",
    },
  });
  const queryClient = useQueryClient();
  const handleSubmit = (val: any) => {
    addDoc(userDbInstance, {
      fullName: val.fullName,
      contactNumber: val.contactNumber,
    }).then(() => router.push("/sign-in"));
  };

  return (
    <>
      <Box sx={{ maxWidth: 300 }} mx="auto">
        <form onSubmit={form.onSubmit(handleSubmit)}>
          <TextInput
            withAsterisk
            label="full name"
            placeholder="your name"
            {...form.getInputProps("fullName")}
          />
          <TextInput
            withAsterisk
            label="contact number"
            placeholder="phone number"
            {...form.getInputProps("contactNumber")}
          />

          <Group position="right" mt="md">
            <Button type="submit">Sign Up</Button>
          </Group>
        </form>
      </Box>
    </>
  );
}
