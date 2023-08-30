import './App.css'
import { BrowserRouter, Route, Routes } from 'react-router-dom'
import { Home } from './home'
import { Blog } from './blog'
import { BlogPost } from './blogpost'

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route index element={ <Home /> } />
        <Route path="/blog" element={ <Blog /> } />
        <Route path="/blog/:post" element={ <BlogPost /> } />
      </Routes>
    </BrowserRouter>
  )
}

