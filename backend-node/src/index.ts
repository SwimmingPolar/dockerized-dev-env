import express, { Request, Response } from "express";

let counter = 0;

const app = express();

app.get("/", (req: Request, res: Response) => {
  console.log("incoming request");
  res.send(`hello from api server current counter: ${counter++}`);
});

app.listen(5611, () => {
  console.log("App running");
});
