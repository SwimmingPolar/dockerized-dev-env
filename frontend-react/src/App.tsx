import React, { useState } from "react";
import logo from "./logo.svg";
import "./App.css";

function App() {
  const [greeting, setGreeting] = useState("");
  const handleClick = () => {
    const getGreeting = async () => {
      const response = await fetch("/api/");
      const text = await response.text();
      setGreeting(text);
    };
    getGreeting();
  };
  return (
    <>
      <h1>Learning Nginx</h1>
      <button onClick={handleClick}>Click to get greeting!!!</button>
      {!!greeting && <p>{greeting}</p>}
    </>
  );
}

export default App;
