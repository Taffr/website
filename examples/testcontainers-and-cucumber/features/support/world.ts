import { IWorldOptions, World as CucumberWorld } from '@cucumber/cucumber';
import { GenericContainer, StartedTestContainer, Wait } from 'testcontainers';
import { startServer, stopServer, StartedServer } from '../../src/server';
import { Config, createConfig } from '../../src/config';

export class TestWorld extends CucumberWorld {
  private started?: StartedServer;
  public config?: Config;
  private mongoContainer?: StartedTestContainer;
  private redisContainer?: StartedTestContainer;
  lastResponse? : { status: number, body: unknown, headers: Record<string, string> };

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
        .withWaitStrategy(Wait.forLogMessage(/Waiting for connections/i))
        .start(),
      new GenericContainer('redis:7-alpine')
        .withWaitStrategy(Wait.forLogMessage(/Ready to accept connections/i))
        .withExposedPorts(6379)
        .start(),
    ]);

    this.mongoContainer = mongoContainer;
    this.redisContainer = redisContainer;

    const mongoPort = mongoContainer.getMappedPort(27017);
    const redisPort = redisContainer.getMappedPort(6379);

    this.config = createConfig({
      port: 0, // NOTE: Let OS assign us a port
      mongoUrl: `mongodb://localhost:${mongoPort}`,
      redisUrl: `redis://localhost:${redisPort}`,
      nodeEnv: 'test'
    });

    this.started = await startServer(this.config);
  }

  get appPort (): number {
    const address = this.started?.server.address();
    if (typeof address === 'string' || !address) {
      throw new Error('Expected server to be started and have a port!');
    }

    return address.port;
  };

  async stop() {
    if (this.started) {
      await stopServer(this.started);
    }
    if (this.mongoContainer) await this.mongoContainer.stop();
    if (this.redisContainer) await this.redisContainer.stop();
  }
}
