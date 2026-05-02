module.exports = {
  url: process.env.URL || 'http://localhost:2368',
  server: {
    port: 2368,
    host: '0.0.0.0'
  },
  database: {
    client: 'mysql',
    connection: {
      host: process.env.MYSQL_HOST,
      port: parseInt(process.env.MYSQL_PORT || '3306', 10),
      user: process.env.MYSQL_USER,
      password: process.env.MYSQL_PASSWORD,
      database: process.env.MYSQL_DATABASE
    }
  },
  mail: {
    transport: 'Direct'
  },
  logging: {
    transports: ['stdout']
  },
  paths: {
    contentPath: '/var/lib/ghost/content'
  }
};
