#!/bin/bash

# Create project structure
mkdir -p devops-demo-app/src
cd devops-demo-app

# Initialize npm project
npm init -y

# Install express
npm install express

# Create src/index.js
cat > src/index.js << 'EOF'
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello from DevOps demo app!');
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
EOF

# Create Dockerfile
cat > Dockerfile << 'EOF'
# Use official Node.js LTS image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the app
COPY . .

# Expose app port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
EOF

# Create .dockerignore
cat > .dockerignore << 'EOF'
node_modules
npm-debug.log
EOF

# Create README.md
cat > README.md << 'EOF'
# DevOps Demo App

A simple Node.js application for demonstrating DevOps practices.

## Running the app

- `npm start` - Start the application
- `docker build -t devops-demo .` - Build Docker image
- `docker run -p 3000:3000 devops-demo` - Run Docker container
EOF

# Update package.json to include start script
jq '.scripts.start = "node src/index.js"' package.json > package.tmp.json && mv package.tmp.json package.json

echo "DevOps demo app setup complete!"
