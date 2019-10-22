import gql from "graphql-tag";
import React from "react";
import { Query } from "react-apollo";

const LIST_USERS = gql`
  {
    listUsers {
      id
      name
      email
    }
  }
`;

const Users = () => (
  <div>
    <h1>Users!</h1>
    <Query query={LIST_USERS}>
      {({ loading, error, data }) => {
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
      }}
    </Query>
  </div>
);

export default Users;
