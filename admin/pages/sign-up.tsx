import { Header, Paper, Text } from "@mantine/core";
import Link from "next/link";
import React from "react";
import SignUpForm from "../src/components/signup-form";
import { HeroText } from "../src/pages/hero";

const SignUp = () => {
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
          Sign Up Form
        </Text>
        <Link href="/sign-in">
          <a
            style={{
              textDecoration: "none",
            }}
          >
            Sign in
          </a>
        </Link>
      </Header>
      <HeroText />
    </>
  );
};

export default SignUp;
