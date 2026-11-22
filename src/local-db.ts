import fs from 'node:fs'
import path from 'node:path'
import { DatabaseSync } from 'node:sqlite'

type SQLValue = string | number | bigint | Uint8Array | null

function normalizeParam(value: unknown): SQLValue {
  if (value === undefined || value === null) return null
  if (typeof value === 'boolean') return value ? 1 : 0
  if (typeof value === 'number' || typeof value === 'string' || typeof value === 'bigint') {
    return value
  }
  if (value instanceof Uint8Array) return value
  return String(value)
}

interface LocalD1Result<T = Record<string, unknown>> {
  results: T[]
  success: boolean
  meta: {
    duration: number
    changes: number
    last_row_id: number
    changed_db: boolean
    size_after: number
    rows_read: number
    rows_written: number
  }
}

class LocalD1PreparedStatement {
  private readonly db: DatabaseSync
  private readonly query: string
  private boundParams: SQLValue[] = []

  constructor(db: DatabaseSync, query: string, boundParams: SQLValue[] = []) {
    this.db = db
    this.query = query
    this.boundParams = boundParams
  }

  bind(...values: unknown[]): LocalD1PreparedStatement {
    return new LocalD1PreparedStatement(
      this.db,
      this.query,
      values.map(normalizeParam)
    )
  }

  async first<T = Record<string, unknown>>(colName?: string): Promise<T | null> {
    const stmt = this.db.prepare(this.query)
    const row = stmt.get(...this.boundParams) as Record<string, unknown> | undefined
    if (!row) return null
    if (colName !== undefined) {
      return (row[colName] ?? null) as T | null
    }
    return { ...row } as T
  }

  async run<T = Record<string, unknown>>(): Promise<LocalD1Result<T>> {
    const start = performance.now()
    const stmt = this.db.prepare(this.query)
    const info = stmt.run(...this.boundParams)
    const changes = Number(info.changes ?? 0)
    const lastRowId = Number(info.lastInsertRowid ?? 0)
    return {
      results: [],
      success: true,
      meta: {
        duration: performance.now() - start,
        changes,
        last_row_id: lastRowId,
        changed_db: changes > 0,
        size_after: 0,
        rows_read: 0,
        rows_written: changes,
      },
    }
  }

  async all<T = Record<string, unknown>>(): Promise<LocalD1Result<T>> {
    const start = performance.now()
    const stmt = this.db.prepare(this.query)
    const trimmed = this.query.trim().toUpperCase()
    const isRead =
      trimmed.startsWith('SELECT') ||
      trimmed.startsWith('PRAGMA') ||
      trimmed.startsWith('WITH') ||
      trimmed.includes('RETURNING')

    if (!isRead) {
      return this.run<T>()
    }

    const rawRows = stmt.all(...this.boundParams) as Record<string, unknown>[]
    const results = rawRows.map((r) => ({ ...r })) as T[]
    return {
      results,
      success: true,
      meta: {
        duration: performance.now() - start,
        changes: 0,
        last_row_id: 0,
        changed_db: false,
        size_after: 0,
        rows_read: results.length,
        rows_written: 0,
      },
    }
  }

  async raw<T = unknown[]>(options?: { columnNames?: boolean }): Promise<T[]> {
    const stmt = this.db.prepare(this.query)
    const rows = stmt.all(...this.boundParams) as Record<string, unknown>[]
    if (rows.length === 0) return []
    const cols = Object.keys(rows[0])
    const values = rows.map((r) => cols.map((c) => r[c])) as unknown as T[]
    if (options?.columnNames) {
      return [cols as unknown as T, ...values]
    }
    return values
  }
}

class LocalD1Database {
  private readonly db: DatabaseSync

  constructor(db: DatabaseSync) {
    this.db = db
  }

  prepare(query: string): LocalD1PreparedStatement {
    return new LocalD1PreparedStatement(this.db, query)
  }

  async batch<T = unknown>(statements: LocalD1PreparedStatement[]): Promise<LocalD1Result<T>[]> {
    const results: LocalD1Result<T>[] = []
    this.db.exec('BEGIN')
    try {
      for (const stmt of statements) {
        results.push(await stmt.all<T>())
      }
      this.db.exec('COMMIT')
    } catch (err) {
      this.db.exec('ROLLBACK')
      throw err
    }
    return results
  }

  async exec(query: string): Promise<{ count: number; duration: number }> {
    const start = performance.now()
    this.db.exec(query)
    return { count: 1, duration: performance.now() - start }
  }

  async dump(): Promise<ArrayBuffer> {
    return new ArrayBuffer(0)
  }
}

let cachedDb: D1Database | null = null

function initializeSchemaAndSeed(sqlite: DatabaseSync): void {
  sqlite.exec(`
    CREATE TABLE IF NOT EXISTS _local_migrations (
      name TEXT PRIMARY KEY,
      applied_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
  `)

  const migrationsDir = path.resolve(process.cwd(), 'migrations')
  if (fs.existsSync(migrationsDir)) {
    const files = fs
      .readdirSync(migrationsDir)
      .filter((f) => f.endsWith('.sql'))
      .sort()

    for (const file of files) {
      const existing = sqlite
        .prepare(`SELECT name FROM _local_migrations WHERE name = ?`)
        .get(file)
      if (existing) continue

      const sql = fs.readFileSync(path.join(migrationsDir, file), 'utf8')
      try {
        sqlite.exec(sql)
        sqlite.prepare(`INSERT INTO _local_migrations (name) VALUES (?)`).run(file)
        console.log(`[PureCrest DB] Applied migration: ${file}`)
      } catch (err) {
        const message = err instanceof Error ? err.message : String(err)
        // If a column/table already existed in an older DB file, record and continue safely
        if (message.includes('duplicate column name') || message.includes('already exists')) {
          sqlite.prepare(`INSERT OR IGNORE INTO _local_migrations (name) VALUES (?)`).run(file)
          console.warn(`[PureCrest DB] Migration ${file} partially skipped (already applied): ${message}`)
        } else {
          throw err
        }
      }
    }
  }

  const seedMarker = '__initial_seed__'
  const seeded = sqlite
    .prepare(`SELECT name FROM _local_migrations WHERE name = ?`)
    .get(seedMarker)

  if (!seeded) {
    const seedPath = path.resolve(process.cwd(), 'seed.sql')
    if (fs.existsSync(seedPath)) {
      const propCount = sqlite.prepare(`SELECT COUNT(*) as c FROM properties`).get() as { c: number } | undefined
      if (!propCount || propCount.c === 0) {
        const seedSql = fs.readFileSync(seedPath, 'utf8')
        sqlite.exec(seedSql)
        console.log('[PureCrest DB] Seeded initial database records from seed.sql')
      }
      sqlite.prepare(`INSERT OR IGNORE INTO _local_migrations (name) VALUES (?)`).run(seedMarker)
    }
  }
}

export function getLocalDb(): D1Database {
  if (cachedDb) return cachedDb

  const dbPath = path.resolve(
    process.cwd(),
    process.env.SQLITE_DB_PATH || '.data/purecrest.sqlite'
  )
  fs.mkdirSync(path.dirname(dbPath), { recursive: true })

  const sqlite = new DatabaseSync(dbPath)
  sqlite.exec('PRAGMA journal_mode = WAL;')
  sqlite.exec('PRAGMA foreign_keys = OFF;')

  initializeSchemaAndSeed(sqlite)

  cachedDb = new LocalD1Database(sqlite) as unknown as D1Database
  return cachedDb
}
