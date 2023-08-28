import { EMOJI } from './emoji'

export const About = () => {
  return (
    <div
      style={{
        display: 'flex',
          flexDirection: 'column',
          margin: '1.5%',
      }}
    >
      <h2>
        About
      </h2>
      <b> I am a Software Engineer { EMOJI.WRENCH } { EMOJI.TECHNOLOGIST } </b>
      <b> I work at tretton37 { EMOJI.NINJA } { EMOJI.OFFICE } </b>
      <b> I have a M.Sc. in Engineering from Lunds Tekniska Högskola { EMOJI.GRADUATE } { EMOJI.SCHOOL } </b>
      <b> I enjoy lifting weights and reading the classics { EMOJI.ATHLETE } { EMOJI.BOOK } </b>
      <b> I live in Sweden. { EMOJI.SWEDEN } { EMOJI.MOOSE } </b>
    </div>
  )
}
