import "../styles/globals.css";
import type { AppProps } from "next/app";
import Layout from "../src/components/layout";
import { NotificationsProvider } from "@mantine/notifications";
import {
  useQuery,
  useMutation,
  useQueryClient,
  QueryClient,
  QueryClientProvider,
} from "@tanstack/react-query";
const queryClient = new QueryClient();

function MyApp({ Component, pageProps }: AppProps) {
  return (
    // <Layout>
    <QueryClientProvider client={queryClient}>
      <NotificationsProvider>
        <Component {...pageProps} />
      </NotificationsProvider>
    </QueryClientProvider>
    // </Layout>
  );
}

export default MyApp;
