module.exports = {
  apps : [
    {
      name: "plasmic-backend",
      cwd: "./platform/wab",
      script: "src/wab/server/main.ts",
      interpreter: "node",
      node_args: [
        "-r", "esbuild-register", 
        "-r", "dotenv/config",
        "--max-old-space-size=10000"
      ],
      env: {
        PORT: "3004",
        react_app_socket_host: "http://localhost:3004",
        PLASMIC_HOST: "http://localhost:3004",
        DATABASE_URI: "postgres://wab:SEKRET@localhost:5432/wab",
        WAB_DBNAME: "wab",
        WAB_DBPASSWORD: "SEKRET",
        NODE_ENV: "development",
        PLASMIC_MULTIPLAYER: "false",
        PLASMIC_IMG_OPTIMIZATION: "false",
        REACT_APP_DEFAULT_HOST_URL: "http://localhost:3005/static/host.html",
        REACT_APP_PUBLIC_URL: "http://localhost:3003",
        CODEGEN_HOST: "http://localhost:3004",
        SITE_ASSETS_BUCKET: "plasmic-site-assets",
        SITE_ASSETS_BASE_URL: "https://site-assets.plasmic.app/",
        DISABLE_BWRAP: "1",
        NQ_SQLJS: "1"
      }
    },
    {
      name: "plasmic-frontend",
      cwd: "./platform/wab",
      script: "node_modules/@rsbuild/core/bin/rsbuild.js", // Ruta directa al ejecutable JS
      args: "dev",
      interpreter: "node",
      env: {
        PORT: "3003",
        NODE_ENV: "development",
        PLASMIC_HOST: "http://localhost:3004",
        REACT_APP_PUBLIC_URL: "http://localhost:3003",
        PUBLIC_URL: "http://localhost:3003",
        NODE_OPTIONS: "--max-old-space-size=16384"
      }
    },
    {
      name: "plasmic-host-server",
      cwd: "./plasmic-local-setup/scripts",
      script: "serve_host.js",
      interpreter: "node",
      env: {
        PORT: "3005"
      }
    }
  ]
}
