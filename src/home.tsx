import { useNavigate } from 'react-router-dom'
import { Contact } from './contact'
import { About } from './about'
export const Home = () => {
  const navigate = useNavigate()
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
        <a
          style={{
            cursor: 'pointer'
          }}
          onClick={ () => navigate('/blog') }
        >
          <h2>
            <u>
              Blog
            </u>
          </h2>
        </a>
        <About />
        <Contact/>
     </div>
    </>
  )
}
