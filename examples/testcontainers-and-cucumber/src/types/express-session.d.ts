import 'express-session';

declare module 'express-session' {
  interface SessionData {
    /** The ID of the logged-in user (if any) */
    userId?: string;
  }
}
