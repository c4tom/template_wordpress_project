# WordPress Plugin Development Template

This template provides a development environment for WordPress plugin development using Docker and VS Code devcontainers.

## Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Start the development environment**
   ```bash
   docker-compose up
   ```

3. **Access WordPress**
   Open your browser and go to `http://localhost:8000`

4. **Develop your plugins**
   Add your plugins to the `plugins` directory. They will be automatically linked in the WordPress installation.

## Tools Included
- WordPress
- MySQL
- WP-CLI
- PHP Debugger
- PHP CodeSniffer
- PHP CS Fixer

## Environment Variables
Configure your environment variables in the `.env` file.

## Debugging
Debug your PHP code using the PHP Debug extension in VS Code.

## Linting and Formatting
Use PHP CodeSniffer and PHP CS Fixer for code linting and formatting.
