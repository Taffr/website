import './App.css'

import { Contact } from './contact'
import { About } from './about'

function App() {
  return (
    <>
      <h1>
        Welcome 
      </h1>
      <h2>
        This is the personal website of Simon Tenggren
      </h2>
      <div
        style={{
          display: 'flex',
          flexDirection: 'column',
        }}
      >
        <About />
        <Contact/>
     </div>
    </>
  )
}

export default App
