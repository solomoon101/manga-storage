# NexusScans CDN Server

A high-performance NGINX-based CDN server optimized for serving manga/comic images with advanced caching, security features, and rate limiting.

## Features

- **High Performance**: Optimized NGINX configuration for serving static content
- **Advanced Caching**: Multi-level caching strategy with FastCGI and file caching
- **Security**: Comprehensive security headers and access controls
- **Rate Limiting**: Protection against abuse with configurable rate limits
- **GZIP Compression**: Optimized for image formats (WebP, JPEG, PNG)
- **Health Monitoring**: Built-in health check endpoint
- **Docker Support**: Containerized deployment ready

## Quick Start

1. Clone the repository
2. Build the Docker image:
   ```bash
   docker build -t nexusscans-cdn -f Dockerfile.nginx .
   ```
3. Run the container:
   ```bash
   docker run -d \
     -p 80:80 \
     -v /path/to/your/content:/home/nexusscans-cdn/htdocs/cdn.nexusscans.com \
     nexusscans-cdn
   ```

## Configuration

### Key NGINX Settings

- Worker Processes: Auto-configured based on CPU cores
- Worker Connections: 65,535 concurrent connections
- Client Max Body Size: 100MB
- Gzip Compression Level: 6
- Cache TTL: 1 year for static content
- Rate Limit: 10 requests/second per IP with burst of 20

### Security Features

- HTTP Security Headers
- XSS Protection
- Content Security Policy
- CORS Configuration
- Hidden Files Protection
- Method Restrictions (GET/OPTIONS only)

## Directory Structure

```
└── public/
    └── [image files]
```

## Rate Limiting

The CDN implements rate limiting with the following rules:

- 10 requests per second per IP address
- Burst allowance of 20 requests
- Returns 429 status code when exceeded

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

[MIT](LICENSE)

## Support

For support, please [aeltrach@gmail.com](mailto:aeltrach@gmail.com)
