# bitsofcode.io

A handmade, lightweight blog engine built from scratch with Elixir. This is a custom-crafted solution that serves markdown articles with YAML front matter support, designed for simplicity and speed.

## Overview

This project is a handbuilt web server that compiles and serves markdown articles at startup. Articles are stored in memory for fast access and compiled from markdown files with optional YAML front matter for metadata. Every component was thoughtfully selected and integrated to create a minimal, efficient blogging platform.

## Features

- ✅ Compile articles on startup for fast serving
- ✅ Serve articles from memory for speed
- ✅ Read front matter YAML from markdown files for metadata
- 🔄 Directory structure-based URL routing (planned)

## Handmade Architecture

This blog engine was built from the ground up using carefully chosen libraries:

### Core Libraries
- **[Bandit](https://hex.pm/packages/bandit)** - Modern HTTP/1.1 and HTTP/2 server for fast, concurrent request handling
- **[Plug](https://hex.pm/packages/plug)** - Composable web application framework providing the routing and middleware foundation
- **[Earmark](https://hex.pm/packages/earmark)** - Pure Elixir markdown parser for converting content to HTML
- **[YamlElixir](https://hex.pm/packages/yaml_elixir)** - YAML parser for processing article front matter metadata

### Design Philosophy

This engine embraces simplicity over complexity:
- **Memory-first**: Articles compiled once at startup, served from RAM
- **Minimal dependencies**: Only essential libraries, no heavyweight frameworks
- **File-based content**: Simple markdown files with optional YAML metadata

### Key Components

- `Boc.Router` - Handles HTTP routing and article serving
- `Boc.Articles.DB` - In-memory article storage using Agent
- `Boc.Articles` - Article compilation and processing pipeline
- `Boc.Markdown` - Markdown parsing with front matter extraction
- `Boc.Layout` - EEx template rendering system

## Getting Started

### Prerequisites

- Elixir 1.18 or later
- Mix build tool

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   mix deps.get
   ```

### Running the Server

Start the development server:
```bash
mix run --no-halt
```

The server will start and compile all markdown articles from `priv/articles/` into memory.

### Adding Articles

1. Create markdown files in `priv/articles/`
2. Optionally add YAML front matter for metadata:
   ```markdown
   ---
   title: "My Article Title"
   date: "2024-01-01"
   ---

   # Article Content

   Your markdown content here...
   ```
3. Restart the server to compile new articles

### URL Structure

- `/` - Serves the home article (`priv/articles/home.md`)
- `/:key` - Serves article with matching filename (without extension)

## Development

### Testing

Run tests with:
```bash
mix test
```
