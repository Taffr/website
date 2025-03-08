import { defineConfig } from 'vite'
import elmPlugin from 'vite-plugin-elm'

console.log('running config')
console.log(elmPlugin())
export default defineConfig({
  plugins:[ elmPlugin() ],
})
