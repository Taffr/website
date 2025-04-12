import { defineConfig } from 'vite'
import { resolve } from 'path'
import elmPlugin from 'vite-plugin-elm'

export default defineConfig({
  plugins:[ elmPlugin() ],
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        cv: resolve(__dirname, 'cv.html'),
        blog: resolve(__dirname, 'blog/index.html'),
      }
    }
  }
})
