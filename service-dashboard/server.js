const http = require("node:http");
const { readFile } = require("node:fs/promises");

const dashboardFile = `${__dirname}/index.html`;

http.createServer(async (request, response) => {
  if (request.url !== "/" && request.url !== "/index.html") {
    response.writeHead(404);
    response.end("Not found");
    return;
  }

  try {
    const html = await readFile(dashboardFile);
    response.writeHead(200, { "Content-Type": "text/html; charset=utf-8" });
    response.end(html);
  } catch (error) {
    console.error("Could not load the service dashboard:", error);
    response.writeHead(500);
    response.end("Internal server error");
  }
}).listen(8080, "0.0.0.0", () => {
  console.log("Service dashboard listening on port 8080");
});
