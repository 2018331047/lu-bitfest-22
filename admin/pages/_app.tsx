import "../styles/globals.css";
import type { AppProps } from "next/app";
import Layout from "../src/components/layout";
import { NotificationsProvider } from "@mantine/notifications";

function MyApp({ Component, pageProps }: AppProps) {
  return (
    // <Layout>
    <NotificationsProvider>
      <Component {...pageProps} />
    </NotificationsProvider>
    // </Layout>
  );
}

export default MyApp;
