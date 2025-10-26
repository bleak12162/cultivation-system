/**
 * 栽培履歴管理システム - サンプルデータ挿入スクリプト
 *
 * 使い方：
 * node insert-sample-data.js [数]
 * 例: node insert-sample-data.js 3   (3つのサンプルデータを作成)
 */

import fetch from 'node-fetch';

// APIのベースURL
const API_URL = process.env.API_URL || 'http://localhost:3000/api/records';

// サンプルデータを生成する関数
function generateSampleData(index) {
  const farmers = ['山田太郎', '佐藤花子', '鈴木次郎', '佐々木美咲'];
  const products = ['ミニトマト', 'キャベツ', 'ニンジン', 'ナス', 'キュウリ'];
  const organizations = ['○○農園', '△△ファーム', '□□営農'];

  const today = new Date();
  const startDate = new Date(today);
  startDate.setMonth(startDate.getMonth() - 3);

  const farmerName = farmers[index % farmers.length];
  const productName = products[index % products.length];
  const org = organizations[index % organizations.length];

  return {
    // 記入者情報
    recorder_name: farmerName,
    recorder_org: org,
    recorder_address: `大阪府吹田市${farmerName}地区`,
    recorder_tel: `06-${Math.floor(Math.random() * 9000) + 1000}-${Math.floor(Math.random() * 9000) + 1000}`,
    recorder_fax: `06-${Math.floor(Math.random() * 9000) + 1000}-${Math.floor(Math.random() * 9000) + 1000}`,

    // 生産者情報
    producer_name: farmers[(index + 1) % farmers.length],
    producer_org: org,

    // 商品情報
    product_name: productName,
    product_spec: '秀品',
    cultivation_variety: productName === 'ミニトマト' ? 'アイコ' : productName === 'キャベツ' ? '寒玉' : '標準品種',
    planting_area: Math.floor(Math.random() * 500) + 100,
    plant_count: Math.floor(Math.random() * 5000) + 500,
    expected_yield: Math.floor(Math.random() * 2000) + 500,
    cultivation_type: '促成栽培',

    // 種子・育苗
    seed_type: Math.random() > 0.5 ? 'purchase' : 'self',
    seed_supplier: '○○種苗店',
    seedling_method: 'self',

    // 肥料使用履歴
    fertilizers: [
      {
        date: new Date(startDate).toISOString().split('T')[0],
        name: '牛糞堆肥',
        material: '牛糞',
        maker: '農産物センター',
        amount: Math.floor(Math.random() * 500) + 200,
        notes: '基肥'
      },
      {
        date: new Date(new Date(startDate).getTime() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        name: 'ニーム油かす',
        material: 'ニーム',
        maker: '有機肥料協会',
        amount: Math.floor(Math.random() * 300) + 100,
        notes: '追肥1回目'
      },
      {
        date: new Date(new Date(startDate).getTime() + 60 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        name: '鶏糞肥料',
        material: '鶏糞',
        maker: '自然派肥料',
        amount: Math.floor(Math.random() * 200) + 50,
        notes: '追肥2回目'
      }
    ],

    // 農薬使用履歴
    pesticides: [
      {
        date: new Date(new Date(startDate).getTime() + 45 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        name: 'ニーム油',
        ingredient: 'ニーム精油',
        maker: '天然農薬メーカー',
        dilution: '500倍',
        target: 'アブラムシ、ハダニ'
      },
      {
        date: new Date(new Date(startDate).getTime() + 75 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        name: '木酢液',
        ingredient: '木酢液',
        maker: '自然派',
        dilution: '100倍',
        target: 'うどんこ病予防'
      }
    ],

    // 作業記録
    works: [
      {
        type: 'seeding',
        content: '温床で育苗開始',
        startDate: new Date(startDate).toISOString().split('T')[0],
        endDate: new Date(new Date(startDate).getTime() + 7 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        fertRef: '1',
        pestRef: '-',
        notes: '気温管理に注意'
      },
      {
        type: 'planting',
        content: '本圃へ定植',
        startDate: new Date(new Date(startDate).getTime() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        endDate: new Date(new Date(startDate).getTime() + 35 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        fertRef: '2',
        pestRef: '-',
        notes: '雨の日を避けて定植'
      },
      {
        type: 'fertilizer',
        content: '追肥施用',
        startDate: new Date(new Date(startDate).getTime() + 45 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        endDate: new Date(new Date(startDate).getTime() + 45 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        fertRef: '2',
        pestRef: '1',
        notes: '開花期前の施肥'
      },
      {
        type: 'pest-control',
        content: '病害虫防除',
        startDate: new Date(new Date(startDate).getTime() + 60 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        endDate: new Date(new Date(startDate).getTime() + 60 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        fertRef: '-',
        pestRef: '1',
        notes: 'アブラムシ防除'
      },
      {
        type: 'harvest',
        content: '初回収穫',
        startDate: new Date(new Date(startDate).getTime() + 90 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        endDate: new Date(today).toISOString().split('T')[0],
        fertRef: '-',
        pestRef: '-',
        notes: '毎日早朝に収穫'
      }
    ],

    // 前作物
    prev_crop_name: 'キャベツ',
    cultivation_class: 'special'
  };
}

// APIにデータを送信する関数
async function sendData(data) {
  try {
    const response = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    });

    if (!response.ok) {
      throw new Error(`HTTP Error: ${response.status}`);
    }

    const result = await response.json();
    return result;
  } catch (error) {
    throw error;
  }
}

// メイン処理
async function main() {
  const count = parseInt(process.argv[2]) || 1;

  console.log('🌱 栽培履歴管理システム - サンプルデータ挿入');
  console.log(`📝 ${count}個のサンプルデータを作成します\n`);

  for (let i = 0; i < count; i++) {
    try {
      const data = generateSampleData(i);
      console.log(`⏳ [${i + 1}/${count}] データを送信中...`);
      console.log(`   - 商品: ${data.product_name}`);
      console.log(`   - 記入者: ${data.recorder_name}`);

      const result = await sendData(data);
      console.log(`✅ [${i + 1}/${count}] 成功! ID: ${result.id}\n`);
    } catch (error) {
      console.error(`❌ [${i + 1}/${count}] エラー: ${error.message}\n`);
    }
  }

  console.log('🎉 完了！');
}

main().catch(console.error);
