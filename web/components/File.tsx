/* eslint-disable @next/next/no-img-element */
import { useContext, useState } from "react";
import { FileWithPath } from "react-dropzone";
import { useQuery } from "@tanstack/react-query";
import ConfigContext from "./ConfigContext";

type Props = {
  file: FileWithPath;
};

type QueryAnswer = {
  id: string;
  original: string;
  big: string;
  medium: string;
  small: string;
  tiny: string;
};

const File: React.FC<Props> = ({ file }) => {
  const backendEndpoint = useContext(ConfigContext);
  const [randomId, _setRandomId] = useState<number>(
    Math.floor(Math.random() * 1_000_000)
  );

  const { isLoading, error, data } = useQuery<unknown, Error, QueryAnswer>(
    ["upload", randomId],
    async () => {
      const uploadEndpoint = new URL("/image", backendEndpoint).toString();
      const formData = new FormData();
      formData.append("file", file);
      const response = await fetch(uploadEndpoint, {
        method: "POST",
        body: formData,
      });
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
    return (
      <div className="file-item">
        <p>
          <strong>{file.path}</strong> - {file.size} bytes
        </p>
        <p>Uploading…</p>
      </div>
    );
  }

  if (error || !data) {
    const errorMessage = error?.message || "Something went wrong…";

    return (
      <div className={`file-item file-item-errored`}>
        <p>
          <strong>{file.path}</strong> - {file.size} bytes
        </p>
        <p>ERROR: {errorMessage}</p>
      </div>
    );
  }

  const originalUrl = new URL(data.original, backendEndpoint).toString();
  const bigUrl = new URL(data.big, backendEndpoint).toString();
  const mediumUrl = new URL(data.medium, backendEndpoint).toString();
  const smallUrl = new URL(data.small, backendEndpoint).toString();
  const tinyUrl = new URL(data.tiny, backendEndpoint).toString();

  return (
    <div className="file-item">
      <p>
        <img src={originalUrl} alt={data.id} />
      </p>
      <p>
        Full-size:{" "}
        <a href={originalUrl} target="_blank" rel="noreferrer">
          {originalUrl}
        </a>
      </p>
      <p>
        Big:{" "}
        <a href={bigUrl} target="_blank" rel="noreferrer">
          {bigUrl}
        </a>
      </p>
      <p>
        Medium:{" "}
        <a href={mediumUrl} target="_blank" rel="noreferrer">
          {mediumUrl}
        </a>
      </p>
      <p>
        Small:{" "}
        <a href={smallUrl} target="_blank" rel="noreferrer">
          {smallUrl}
        </a>
      </p>
      <p>
        Tiny:{" "}
        <a href={tinyUrl} target="_blank" rel="noreferrer">
          {tinyUrl}
        </a>
      </p>
    </div>
  );
};

export default File;
