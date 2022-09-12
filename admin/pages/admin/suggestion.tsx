import { Table, Text } from "@mantine/core";
import { useQuery } from "@tanstack/react-query";
import { collection, getDocs } from "firebase/firestore";
import React, { useEffect, useState } from "react";
import { database } from "../../src/lib";

const requestsDbInstance = collection(database, "requests");
export const getRequests = () => {
  return getDocs(requestsDbInstance).then((data: any) => {
    const dt = data.docs.map((item: any) => {
      return { ...item.data(), id: item.id };
    });
    return dt;
  });
};
const Suggestion = () => {
  const { data } = useQuery(["requests"], getRequests);
  const [values, setValues] = useState({
    teacher: [],
    student: [],
    "staff&official": [],
  });
  useEffect(() => {
    table();
  }, [data]);
  const table = () => {
    const helper = (item) => {
      const count = data?.filter((dt) => {
        const it = dt["pick-up"] + "-" + dt.time;
        return it === item;
      }).length;
      return {
        [item]: count,
      };
    };
    const students = data?.filter((dt) => dt.user_type === "student");
    const studentsUnique = new Set(
      students?.map((dt) => dt["pick-up"] + "-" + dt.time)
    );
    const studntCounts = [...studentsUnique];
    setValues((prev) => ({ ...prev, student: studntCounts.map(helper) }));

    const teachers = data?.filter((dt) => dt.user_type === "teacher");
    const teachersUnique = new Set(
      teachers?.map((dt) => dt["pick-up"] + "-" + dt.time)
    );
    const teacherCounts = [...teachersUnique];
    setValues((prev) => ({ ...prev, teacher: teacherCounts.map(helper) }));
  };

  const getHeader = () => {
    return (
      <tr>
        <th>Pick-up point and time</th>
        <th>count</th>
      </tr>
    );
  };
  const getRows = (data: any) => {
    return data.map((element: any, ind: Number) => (
      <tr key={ind}>
        <td>{Object.keys(element)}</td>
        <td>{Object.values(element)}</td>
      </tr>
    ));
  };
  console.log(values);
  return (
    <div>
      <Text>Students</Text>
      <Table horizontalSpacing="xl" verticalSpacing="xl" fontSize="lg">
        <thead>{getHeader()}</thead>
        <tbody>{getRows(values.student)}</tbody>
      </Table>

      <Text>Teachers</Text>
      <Table horizontalSpacing="xl" verticalSpacing="xl" fontSize="lg">
        <thead>{getHeader()}</thead>
        <tbody>{getRows(values.teacher)}</tbody>
      </Table>
    </div>
  );
};

export default Suggestion;
