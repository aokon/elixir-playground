// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/live")
liveSocket.connect()

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
//
import React from "react";
import ReactDOM from "react-dom";
import { ApolloProvider } from "react-apollo";
import Turbolinks from "turbolinks";
import { createClient } from "./utils/apollo";
import ErrorBoundary from "./components/ErrorBoundary/ErrorBoundary";
import HelloPane from "./components/Hello/Hello";
import Users from "./components/Users/Users";

const routes = {
  "/": HelloPane,
  "/users": Users
};

const renderComponent = (path) => {
  const Component = routes[path];
  const container = document.getElementById("container");

  if(Component && container) {
    const client = createClient();
    const App = () => (
      <div id="app">
        <ApolloProvider client={client}>
          <ErrorBoundary>
            <Component />
          </ErrorBoundary>
        </ApolloProvider>
      </div>
    );
    ReactDOM.render(<App />, container);
  }
};

document.addEventListener("turbolinks:load", event => {
  renderComponent(window.location.pathname);
});

Turbolinks.start();

