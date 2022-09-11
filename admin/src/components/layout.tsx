// components/layout.js

import { HeaderResponsive } from "./header";

const links = [
  { link: "/sign-up", label: "sign-up" },
  { link: "/sign-in", label: "sign-in" },
];

export default function Layout({ children }: any) {
  return (
    <>
      <HeaderResponsive links={links} />
      <main>{children}</main>
    </>
  );
}
