import { serve } from '@hono/node-server'
import { serveStatic } from '@hono/node-server/serve-static'
import { Hono } from 'hono'
import app from './src/index.tsx'
import { getLocalDb } from './src/local-db.ts'

const db = getLocalDb()
const server = new Hono()

// Serve static assets from public/ (mirrors Cloudflare Pages static serving)
server.use('/static/*', serveStatic({ root: './public' }))
server.use('/purecrest-logo.png', serveStatic({ path: './public/purecrest-logo.png' }))
server.use('/purecrest-logo-transparent.png', serveStatic({ path: './public/purecrest-logo-transparent.png' }))

// Health check endpoint
server.get('/api/health', async (c) => {
  try {
    const props = await db.prepare(`SELECT COUNT(*) as c FROM properties`).first<{ c: number }>()
    const posts = await db.prepare(`SELECT COUNT(*) as c FROM blog_posts`).first<{ c: number }>()
    return c.json({
      status: 'ok',
      runtime: 'node-sqlite',
      properties: props?.c ?? 0,
      blog_posts: posts?.c ?? 0,
    })
  } catch (err) {
    return c.json({ status: 'error', message: String(err) }, 500)
  }
})

// Forward all other routes to the Cloudflare Pages Hono app with local D1 binding
server.all('*', async (c) => {
  return app.fetch(c.req.raw, { DB: db })
})

const port = Number(process.env.PORT || 3000)

serve(
  {
    fetch: server.fetch,
    port,
    hostname: '0.0.0.0',
  },
  (info) => {
    console.log(`PureCrest server running at http://0.0.0.0:${info.port}`)
  }
)
