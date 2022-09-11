import { TextInput, Checkbox, Button, Group, Box } from "@mantine/core";
import { useForm } from "@mantine/form";

export default function SignUpForm() {
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

  return (
    <Box sx={{ maxWidth: 300 }} mx="auto">
      <form onSubmit={form.onSubmit((values) => console.log(values))}>
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
          <Button type="submit">Submit</Button>
        </Group>
      </form>
    </Box>
  );
}
