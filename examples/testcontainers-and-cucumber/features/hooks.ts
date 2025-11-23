import { After, Before, setWorldConstructor } from '@cucumber/cucumber'
import { TestWorld } from './support/world'


setWorldConstructor(TestWorld)

// Start the world
Before({ timeout: 30_000 }, async function (this: TestWorld) {
  await this.start();
});

// Stop the world
After(async function (this: TestWorld) {
  await this.stop();
});
