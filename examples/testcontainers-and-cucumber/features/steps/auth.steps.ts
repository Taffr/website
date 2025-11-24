import { Given, When, Then, DataTable } from '@cucumber/cucumber';
import { expect } from 'chai';
import { TestWorld } from '../support/world';

Given('I register a new user with', async function (this: TestWorld, dataTable: DataTable) {
  if (!this.config) throw new Error('Config not initialized');
  const [ { email, password } ] = dataTable.hashes();

  const res = await fetch(`http://localhost:${this.config.port}/api/auth/register`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password })
  });

  const body = await res.json();
  this.lastResponse = { status: res.status, body, headers: Object.fromEntries(res.headers.entries()) };
});

When('I login with email {string} and password {string}', async function (this: TestWorld, email: string, password: string) {
  if (!this.config) throw new Error('Config not initialized');
  const res = await fetch(`http://localhost:${this.config.port}/api/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password })
  });
  const body = await res.json();
  this.lastResponse = { status: res.status, body, headers: Object.fromEntries(res.headers.entries()) };
});

Then('I am made aware that the user is already registered', function (this: TestWorld) {
  expect(this.lastResponse).to.exist;
  expect(this.lastResponse?.status).to.equal(409);
});

Then('I have successfully registered', function (this: TestWorld) {
  expect(this.lastResponse).to.exist;
  expect(this.lastResponse?.status).to.equal(201);
});

Then('I am logged in', function () {
  const setCookie = this.lastResponse.headers?.['set-cookie'];
  expect(setCookie).to.be.an('string').that.includes('connect.sid');
});

Then('I am denied', function () {
  expect(this.lastResponse).to.exist;
  expect(this.lastResponse?.status).to.equal(401);
});
