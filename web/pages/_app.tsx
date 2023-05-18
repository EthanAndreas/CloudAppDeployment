import "../styles/globals.css";
import type { AppProps } from "next/app";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import Config from "../components/Config";

const queryClient = new QueryClient();

function MyApp({ Component, pageProps }: AppProps) {
  return (
    <QueryClientProvider client={queryClient}>
      <Config>
        <Component {...pageProps} />
      </Config>
    </QueryClientProvider>
  );
}

export default MyApp;
