export interface Config {
  port: number;
  mongoUrl: string;
  redisUrl: string;
  sessionSecret: string;
  nodeEnv: 'development' | 'production' | 'test';
}

export function createConfig(overrides?: Partial<Config>): Config {
  return {
    port: overrides?.port ?? 4000,
    mongoUrl: overrides?.mongoUrl ?? 'mongodb://localhost:27017/myapp',
    redisUrl: overrides?.redisUrl ?? 'redis://localhost:6379',
    sessionSecret: overrides?.sessionSecret ?? 'keyboard_cat_change_me',
    nodeEnv: overrides?.nodeEnv ?? 'test'
  };
}
