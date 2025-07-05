import { defineConfig } from 'vite'
import { resolve } from 'path'
import elmPlugin from 'vite-plugin-elm'
import fg from 'fast-glob'

const htmlFiles = fg.sync([
  'index.html',
  'cv.html',
  'blog/**/*.html'
]).reduce((entries, file) => {
  // Preserve the nested path (minus the .html)
  const name = file.replace(/\.html$/, '')
  entries[name] = resolve(__dirname, file)
  return entries
}, {})

export default defineConfig({
  plugins: [ elmPlugin() ],
  build: {
    rollupOptions: {
      input: htmlFiles
    }
  }
})
