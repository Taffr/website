import { Router, type Request, type Response } from 'express';
import { type Db } from 'mongodb';
import bcrypt from 'bcrypt';

interface User {
  _id: string;
  email: string;
  passwordHash: string;
}

interface NewUser {
  email: string;
  passwordHash: string;
}

async function findUserByEmail(db: Db, email: string): Promise<User | null> {
  const doc = await db.collection('users').findOne<{ _id: any; email: string; passwordHash: string }>({ email });
  if (!doc) return null;
  return { _id: doc._id.toHexString(), email: doc.email, passwordHash: doc.passwordHash };
}

async function createUser(db: Db, user: NewUser): Promise<User> {
  const result = await db.collection('users').insertOne({ email: user.email, passwordHash: user.passwordHash });
  return { _id: result.insertedId.toHexString(), email: user.email, passwordHash: user.passwordHash };
}

export function authRouter({ db }: { db: Db }) {
  const router = Router();

  router.post('/register', async (req: Request, res: Response) => {
    const { email, password } = req.body as { email?: string; password?: string };
    if (!email || !password) return res.status(400).json({ message: 'Email and password required' });
    const existing = await findUserByEmail(db, email);
    if (existing) return res.status(409).json({ message: 'User already exists' });
    const hashed = await bcrypt.hash(password, 10);
    const user = await createUser(db, { email, passwordHash: hashed });
    (req.session as any).userId! = user._id;
    return res.status(201).json({ id: user._id, email: user.email });
  });

  router.post('/login', async (req: Request, res: Response) => {
    const { email, password } = req.body as { email?: string; password?: string };
    if (!email || !password) return res.status(400).json({ message: 'Email and password required' });

    const user = await findUserByEmail(db, email);
    if (!user) return res.status(401).json({ message: 'Invalid credentials' });

    const ok = await bcrypt.compare(password, user.passwordHash);
    if (!ok) return res.status(401).json({ message: 'Invalid credentials' });

    (req.session as any).userId = user._id;
    return res.json({ id: user._id, email: user.email });
  });

  router.post('/logout', (req: Request, res: Response) => {
    req.session.destroy((err) => {
      if (err) return res.status(500).json({ message: 'Logout failed' });
      res.clearCookie('connect.sid');
      return res.json({ ok: true });
    });
  });

  return router;
}
