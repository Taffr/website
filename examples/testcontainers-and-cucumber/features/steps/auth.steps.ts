import { Given, When, Then, After } from '@cucumber/cucumber';
import { expect } from 'chai';
import { TestWorld } from '../support/world';

let lastResponse: { status: number; body: any; headers?: any };

Given('the app is running', async function (this: TestWorld) {
  await this.start();
});

When('I register with email {string} and password {string}', async function (this: TestWorld, email: string, password: string) {
  if (!this.config) throw new Error('Config not initialized');
  const res = await fetch(`http://localhost:${this.config.port}/api/auth/register`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password })
  });
  const body = await res.json();
  lastResponse = { status: res.status, body, headers: Object.fromEntries(res.headers.entries()) };
});

When('I login with email {string} and password {string}', async function (this: TestWorld, email: string, password: string) {
  if (!this.config) throw new Error('Config not initialized');
  const res = await fetch(`http://localhost:${this.config.port}/api/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password })
  });
  const body = await res.json();
  lastResponse = { status: res.status, body, headers: Object.fromEntries(res.headers.entries()) };
});

Then('I should receive a {int} response', function (status: number) {
  expect(lastResponse).to.exist;
  expect(lastResponse.status).to.equal(status);
});

Then('a session cookie should be set', function () {
  const setCookie = lastResponse.headers?.['set-cookie'];
  expect(setCookie).to.be.an('string').that.includes('connect.sid');
});

After(async function (this: TestWorld) {
  await this.stop();
});
