# Frontend

Requirements:

- NodeJS: https://nodejs.org/en/ (`node` and `npm` commands)

## Configuration

The application loads a configuration file on start which lives in the [`public/`](./public/config.json) folder.
This configuration file sets the URL of the API to use.

## Quick Start

```sh
npm install # install dependencies
npm run dev # start the development environment
```

And navigate to <http://localhost:3000/>

This environment automatically reloads when files are edited.

## Build for production

```sh
npm ci # install dependencies
npm run build # create an optimized build for production
npm run start # serve the built version
```

And navigate to <http://localhost:3000/>
