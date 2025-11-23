import http from 'http';
import express, { Express } from 'express';
import session from 'express-session';
import { RedisStore } from 'connect-redis';
import { createClient, type RedisClientType } from 'redis';
import { MongoClient } from 'mongodb';
import type { Config } from './config';
import cors from 'cors';
import { authRouter } from './routes/auth';

export interface StartedServer {
  server: http.Server;
  mongoClient: MongoClient;
  redisClient: RedisClientType;
}

export async function startServer(config: Config): Promise<StartedServer> {
  const redisClient: RedisClientType = createClient({ url: config.redisUrl });
  redisClient.on('error', console.error);

  const mongoClient = new MongoClient(config.mongoUrl);

  await Promise.all([
    mongoClient.connect(),
    redisClient.connect(),
  ]);

  const db = mongoClient.db();
  const app: Express = express();

  app.use(express.json());
  app.use(cors({ origin: true, credentials: true }));
  app.use(
    session({
      store: new RedisStore({ client: redisClient }),
      secret: config.sessionSecret,
      resave: false,
      saveUninitialized: false,
      cookie: { httpOnly: true, secure: config.nodeEnv === 'production' }
    })
  );

  app.use('/api/auth', authRouter({ db }));
  app.get('/api/health', (_req, res) => res.json({ ok: true }));

  const server = app.listen(config.port);
  return { server, mongoClient, redisClient };
}

export async function stopServer(started: StartedServer) {
  started.redisClient.disconnect(),
  await Promise.all([
    started.mongoClient.close(),
    new Promise((res) => started.server.close(res)),
  ]);
}
