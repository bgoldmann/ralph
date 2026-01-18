---
name: mcp
description: "Model Context Protocol (MCP) integration for connecting LLMs to external tools, data sources, and prompts. Use when integrating MCP servers, building MCP clients, creating tools/resources/prompts, or connecting AI applications to external capabilities. Triggers on: mcp, model context protocol, mcp server, mcp client, mcp tools, mcp resources, mcp prompts."
---

# MCP (Model Context Protocol) Skills

Comprehensive guide for integrating and working with Model Context Protocol (MCP) in applications. Covers MCP servers, clients, tools, resources, prompts, security, and best practices.

## Overview

Model Context Protocol (MCP) is an open standard protocol (from Anthropic) for connecting LLMs to external tools, data sources, and prompts via a standardized interface. It enables AI hosts (e.g., Claude, ChatGPT, or custom apps) to call external "skills" in a uniform way.

## Key Components

- **MCP Host**: The AI application that wants to use skills
- **MCP Client**: The component in the host that opens and maintains connections to MCP servers
- **MCP Server(s)**: Expose sets of skills:
  - **Tools**: Executable actions with defined inputs/outputs
  - **Resources**: Data, files, databases accessible by the host
  - **Prompts**: Templated instructions that can be invoked

## When to Use MCP

Use MCP when you need to:

- Connect AI applications to external tools or APIs
- Provide structured access to data sources (databases, files, APIs)
- Create reusable prompt templates for LLM interactions
- Build extensible AI agent systems with pluggable capabilities
- Standardize communication between AI hosts and external services

## Quick Start

### Installation

```bash
# TypeScript/JavaScript
npm install @modelcontextprotocol/sdk

# Python
pip install mcp
```

### Basic Server Setup (TypeScript)

```typescript
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';

const server = new Server({
  name: 'my-server',
  version: '1.0.0',
});

// Define tools
server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: 'my-tool',
      description: 'Does something useful',
      inputSchema: {
        type: 'object',
        properties: {
          input: { type: 'string' },
        },
        required: ['input'],
      },
    },
  ],
}));

// Handle tool calls
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;
  // Implement tool logic
  return { content: [{ type: 'text', text: 'Result' }] };
});

// Start server
const transport = new StdioServerTransport();
await server.connect(transport);
```

### Basic Client Setup (TypeScript)

```typescript
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { StdioClientTransport } from '@modelcontextprotocol/sdk/client/stdio.js';

const client = new Client({
  name: 'my-client',
  version: '1.0.0',
});

const transport = new StdioClientTransport({
  command: 'node',
  args: ['server.js'],
});

await client.connect(transport);

// List tools
const { tools } = await client.listTools();

// Call tool
const result = await client.callTool({
  name: 'my-tool',
  arguments: { input: 'value' },
});
```

## Defining Skills

### Tools

Tools are executable actions with schemas:

```typescript
{
  name: 'search-database',
  description: 'Search the database',
  inputSchema: {
    type: 'object',
    properties: {
      query: { type: 'string' },
      limit: { type: 'number', default: 10 },
    },
    required: ['query'],
  },
}
```

### Resources

Resources provide access to data:

```typescript
{
  uri: 'file://notes/example.md',
  name: 'Example Note',
  description: 'A markdown note',
  mimeType: 'text/markdown',
}
```

### Prompts

Prompts are templated instructions:

```typescript
{
  name: 'code-review',
  description: 'Template for code review',
  arguments: [
    { name: 'code', description: 'Code to review', required: true },
  ],
}
```

## Security Best Practices

1. **Authentication**: Validate requests with tokens
2. **Authorization**: Check permissions per tool/resource
3. **Input Validation**: Always validate against schemas
4. **Least Privilege**: Expose only necessary functionality
5. **Audit Logging**: Log all tool calls and resource access
6. **Sandboxing**: Run risky operations in isolated environments

## Transport Protocols

MCP supports JSON-RPC 2.0 over:

- **stdio**: Standard input/output (local development)
- **HTTP**: HTTP-based transport (remote servers)
- **WebSocket**: Real-time bidirectional communication
- **SSE**: Server-Sent Events (streaming)

## Common Use Cases

1. **Database Access**: Expose database queries as tools
2. **File Operations**: Provide file read/write capabilities
3. **API Integration**: Connect to external APIs
4. **Code Generation**: Tools for code analysis and generation
5. **Data Processing**: Transform and process data
6. **System Administration**: Safe system operations

## Error Handling

```typescript
try {
  const result = await client.callTool({ /* ... */ });
} catch (error) {
  if (error.isError) {
    console.error('Tool error:', error.message);
  } else {
    console.error('Connection error:', error);
  }
}
```

## Testing

```typescript
// Unit test tools
describe('MCP Tools', () => {
  it('should execute tool correctly', async () => {
    const result = await server.handleRequest({
      method: 'tools/call',
      params: { name: 'my-tool', arguments: {} },
    });
    expect(result).toBeDefined();
  });
});
```

## Best Practices

1. Define clear tool schemas with types
2. Validate all inputs strictly
3. Provide comprehensive error messages
4. Document tools, resources, and prompts
5. Version tools for backward compatibility
6. Monitor usage and performance
7. Implement proper security measures
8. Test thoroughly before deployment

## External Resources

- Official Docs: <https://modelcontextprotocol.io>
- GitHub: <https://github.com/modelcontextprotocol>
- TypeScript SDK: <https://github.com/modelcontextprotocol/typescript-sdk>
- Python SDK: <https://github.com/modelcontextprotocol/python-sdk>
