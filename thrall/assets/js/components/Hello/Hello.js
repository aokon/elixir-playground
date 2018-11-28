import React from "react";

const onClick = () => alert("Hello!!!");

const HelloPane = () => (
  <section>
    <h1>Hello</h1>
    <p>Lorem Ipsum is simply dummy text of the printing</p>
    <button className="btn btn-primary" onClick={onClick}>Click</button>
  </section>
);

export default HelloPane;

