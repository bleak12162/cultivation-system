import { sql } from '@vercel/postgres';

export default async function handler(req, res) {
  // CORSヘッダーを設定
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }
  
  try {
    // テーブルが存在しない場合は作成
    await initDatabase();
    
    const { method, query, body } = req;
    
    if (method === 'GET') {
      if (query.id) {
        // 詳細取得
        const record = await getRecord(parseInt(query.id));
        return res.status(200).json(record);
      } else {
        // 一覧取得
        const records = await getRecords();
        return res.status(200).json(records);
      }
    }
    
    if (method === 'POST') {
      // 新規作成
      const result = await createRecord(body);
      return res.status(201).json(result);
    }
    
    if (method === 'PUT' && query.id) {
      // 更新
      await updateRecord(parseInt(query.id), body);
      return res.status(200).json({ message: '更新しました' });
    }
    
    if (method === 'DELETE' && query.id) {
      // 削除
      await deleteRecord(parseInt(query.id));
      return res.status(200).json({ message: '削除しました' });
    }
    
    return res.status(405).json({ error: 'Method not allowed' });
    
  } catch (error) {
    console.error('API Error:', error);
    return res.status(500).json({ error: error.message });
  }
}

async function initDatabase() {
  try {
    await sql`
      CREATE TABLE IF NOT EXISTS cultivation_records (
        id SERIAL PRIMARY KEY,
        data JSONB NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `;
  } catch (error) {
    console.error('DB Init Error:', error);
  }
}

async function getRecords() {
  const { rows } = await sql`SELECT id, data, created_at FROM cultivation_records ORDER BY created_at DESC`;
  return rows;
}

async function getRecord(id) {
  const { rows } = await sql`SELECT * FROM cultivation_records WHERE id = ${id}`;
  return rows[0] || null;
}

async function createRecord(data) {
  const { rows } = await sql`
    INSERT INTO cultivation_records (data) 
    VALUES (${JSON.stringify(data)}) 
    RETURNING id
  `;
  return { id: rows[0].id };
}

async function updateRecord(id, data) {
  await sql`
    UPDATE cultivation_records 
    SET data = ${JSON.stringify(data)}, updated_at = CURRENT_TIMESTAMP 
    WHERE id = ${id}
  `;
}

async function deleteRecord(id) {
  await sql`DELETE FROM cultivation_records WHERE id = ${id}`;
}
