// build.js - CommonJS

// Klassische CommonJS-Imports
const esbuild = require("esbuild")
const sveltePlugin = require("esbuild-svelte")
// Bei manchen ESM-Plugins musst du .default verwenden, probiere beides aus:
// const importGlobPlugin = require("esbuild-plugin-import-glob")
// oder:
const importGlobPlugin = require("esbuild-plugin-import-glob").default

const sveltePreprocess = require("svelte-preprocess")

// CLI-Argumente (z. B. --watch, --deploy) ermitteln
const args = process.argv.slice(2)
const watch = args.includes("--watch")
const deploy = args.includes("--deploy")

// Jetzt kommt die dynamische ESM-Import-Stelle für @melt-ui/pp.
// Wir müssen sie in eine asynchrone IIFE (Immediately Invoked Function Expression) packen,
// damit wir await verwenden können.
;(async () => {
  // ESM-Package @melt-ui/pp via await import(...) laden
  const { sequence, preprocessMeltUI } = await import("@melt-ui/pp")

  // Optional: client/server conditions
  let clientConditions = ["svelte", "browser"]
  let serverConditions = ["svelte"]

  if (!deploy) {
    clientConditions.push("development")
    serverConditions.push("development")
  }

  // Build-Optionen fürs Client-Bundle
  let optsClient = {
    entryPoints: ["js/app.js"],
    bundle: true,
    minify: deploy,
    conditions: clientConditions,
    alias: { svelte: "svelte" },
    outdir: "../priv/static/assets",
    logLevel: "info",
    sourcemap: watch ? "inline" : false,
    tsconfig: "./tsconfig.json",
    plugins: [
      // Glob-Plugin (falls du Import-Globs in deinen Svelte-Files nutzt)
      importGlobPlugin(),
      // sveltePlugin mit Preprocessor-Kette
      sveltePlugin({
        preprocess: sequence([
          sveltePreprocess(),
          preprocessMeltUI(),
        ]),
        compilerOptions: {
          dev: !deploy,
          css: "injected",
          generate: "client",
        },
      }),
    ],
  }

  // Build-Optionen fürs Server-Bundle (SSR)
  let optsServer = {
    entryPoints: ["js/server.js"],
    platform: "node",
    bundle: true,
    minify: false,
    target: "node19.6.1",
    conditions: serverConditions,
    alias: { svelte: "svelte" },
    outdir: "../priv/svelte",
    logLevel: "info",
    sourcemap: watch ? "inline" : false,
    tsconfig: "./tsconfig.json",
    plugins: [
      importGlobPlugin(),
      sveltePlugin({
        preprocess: sequence([
          sveltePreprocess(),
          preprocessMeltUI(),
        ]),
        compilerOptions: {
          dev: !deploy,
          css: "injected",
          generate: "server",
        },
      }),
    ],
  }

  // Abhängig vom --watch-Flag
  if (watch) {
    // Watch-Modus aktivieren
    esbuild
      .context(optsClient)
      .then((ctx) => ctx.watch())
      .catch(() => process.exit(1))

    esbuild
      .context(optsServer)
      .then((ctx) => ctx.watch())
      .catch(() => process.exit(1))
  } else {
    // Nur einmalig builden
    esbuild.build(optsClient)
    esbuild.build(optsServer)
  }
})()
