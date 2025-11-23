import { IWorldOptions, World as CucumberWorld } from '@cucumber/cucumber';
import { GenericContainer, StartedTestContainer } from 'testcontainers';
import { startServer, stopServer, StartedServer } from '../../src/server';
import { Config, createConfig } from '../../src/config';
import { Db } from 'mongodb';

export class TestWorld extends CucumberWorld {
  private started?: StartedServer;
  private config?: Config;
  private mongoContainer?: StartedTestContainer;
  private redisContainer?: StartedTestContainer;

  constructor(options: IWorldOptions) {
    super(options);
  }

  async start() {
    const [
      mongoContainer,
      redisContainer,
    ] = await Promise.all([
      new GenericContainer('mongo:7')
        .withExposedPorts(27017)
        .start(),
      new GenericContainer('redis:7-alpine')
        .withExposedPorts(6379)
        .start(),
    ]);

    this.mongoContainer = mongoContainer;
    this.redisContainer = redisContainer;

    const mongoPort = mongoContainer.getMappedPort(27017);
    const redisPort = redisContainer.getMappedPort(6379);

    this.config = createConfig({
      mongoUrl: `mongodb://localhost:${mongoPort}`,
      redisUrl: `redis://localhost:${redisPort}`,
      nodeEnv: 'test'
    });

    this.started = await startServer(this.config);
  }

  async stop() {
    if (this.started) {
      await stopServer(this.started);
    }
    if (this.mongoContainer) await this.mongoContainer.stop();
    if (this.redisContainer) await this.redisContainer.stop();
  }
}
