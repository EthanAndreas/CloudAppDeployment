import { ReactNode } from "react";
import { useQuery } from "@tanstack/react-query";
import ConfigContext from "./ConfigContext";

type Props = {
  children: ReactNode;
};

type DynamicConfig = {
  endpoint: string;
};

const Config: React.FC<Props> = ({ children }) => {
  const { isLoading, error, data } = useQuery<unknown, Error, DynamicConfig>(
    ["config"],
    async () => {
      const configUrl = new URL(
        "/config.json",
        window.location.href
      ).toString();

      const response = await fetch(configUrl);
      const json = await response.json();
      return json;
    },
    {
      retry: false,
      refetchOnMount: false,
      refetchOnReconnect: false,
      refetchOnWindowFocus: false,
    }
  );

  if (isLoading) {
    return <div>Loading…</div>;
  }

  if (error || !data) {
    return <div>Something went wrong… Please try again!</div>;
  }

  const endpointUrl = data.endpoint;

  if (!endpointUrl) {
    return <div>Endpoint was not specified :(</div>;
  }

  return (
    <ConfigContext.Provider value={endpointUrl}>
      {children}
    </ConfigContext.Provider>
  );
};

export default Config;
