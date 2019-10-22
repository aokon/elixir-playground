import React from "react";
import { useQuery } from '@apollo/react-hooks';
import { gql } from 'apollo-boost';

const LIST_USERS = gql`
  {
    listUsers {
      id
      name
      email
    }
  }
`;

const Users = () => {
  const { loading, error, data } = useQuery(LIST_USERS);

  if (loading) return "Loading...";
  if (error) return `Error! ${error.message}`;

  return (
    <ul>
      {data.listUsers.map(user => (
        <li key={user.id}>
          {user.name}: {user.email}
        </li>
      ))}
    </ul>
  );
};

export default Users;
