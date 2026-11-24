import { Pool, type QueryResult, type QueryResultRow } from "pg";

let pool: Pool | undefined;

const statementBrand: unique symbol = Symbol("SqlStatement");

export type SqlStatement = {
  readonly text: string;
  readonly values: readonly unknown[];
  readonly [statementBrand]: true;
};

export function sql(
  strings: TemplateStringsArray,
  ...values: unknown[]
): SqlStatement {
  let text = "";
  for (let i = 0; i < strings.length; i += 1) {
    text += strings[i];
    if (i < values.length) {
      text += `$${i + 1}`;
    }
  }

  return { text, values, [statementBrand]: true };
}

function getPool(): Pool {
  const connectionString = process.env.DATABASE_URL;
  if (!connectionString) {
    throw new Error("DATABASE_URL is required to connect to PostgreSQL.");
  }

  pool ??= new Pool({ connectionString });
  return pool;
}

export function query<Row extends QueryResultRow = QueryResultRow>(
  statement: SqlStatement,
): Promise<QueryResult<Row>> {
  return getPool().query<Row>({
    text: statement.text,
    values: [...statement.values],
  });
}
