import type { NextPage } from "next";
import Head from "next/head";
import DropZone from "../components/DropZone";

const Home: NextPage = () => {
  return (
    <div>
      <Head>
        <title>imgr.</title>
        <meta name="description" content="imgr." />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>
        <h1>imgr.</h1>
        <DropZone />
      </main>
    </div>
  );
};

export default Home;
