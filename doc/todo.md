# TODO
## MCP

- codebase-memory-mcp
- folgendes:
```
    "intellij": {      
      "type": "streamable-http",
      "url": "http://127.0.0.1:64342/stream",
      "enabled": true
    },
    "playwright": {
      "type": "local",
      "command": ["npx","@playwright/mcp@latest","--browser=chrome"],
      "enabled": true    
    },
    "ui5": {
      "type": "local",
      "command": ["npx","-y","@ui5/mcp-server"],
      "enabled": true
    }
```