import type { NextPage } from "next";
import Head from "next/head";
import Image from "next/image";
import { HeroText } from "../src/pages/hero";
import styles from "../styles/Home.module.css";

const Home: NextPage = () => {
  return (
    <div className={styles.container}>
      <HeroText />
    </div>
  );
};

export default Home;
