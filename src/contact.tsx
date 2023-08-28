const LINKEDIN_URL = 'https://www.linkedin.com/in/simon-tenggren-b30b01143/'
const GITHUB_URL = 'https://www.github.com/Taffr'
const EMAIL = 'simon.tenggren@tretton37.com'

export const Contact = () => {
  return (
    <div
      style={{
        display: 'flex',
          flexDirection: 'column',
          margin: '2%',
      }}
    >
      <h3>
        Contact
      </h3>
      <div
        style={{
          display: 'flex',
            flexDirection: 'row',
            justifyContent: 'space-around',
        }}
      >
        <a href={LINKEDIN_URL} target='_blank'> LinkedIn </a>
        <a href={GITHUB_URL} target='_blank'> GitHub </a>
        <a href={`mailto:${EMAIL}`}> E-Mail Me </a>
      </div>
    </div>
  )
}
