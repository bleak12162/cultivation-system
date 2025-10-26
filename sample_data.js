// 栽培履歴サンプルデータ生成スクリプト
// ブラウザのコンソールで実行してください

const sampleData = {
    recorder_name: "山田太郎",
    recorder_org: "コープ自然派農園",
    recorder_address: "大阪府吹田市山田東1-2-3",
    recorder_tel: "06-1234-5678",
    recorder_fax: "06-1234-5679",
    producer_name: "佐藤花子",
    producer_org: "コープ自然派農園",
    product_name: "ミニトマト",
    product_spec: "150g",
    cultivation_variety: "アイコ",
    planting_area: "500",
    plant_count: "1000",
    expected_yield: "3000",
    cultivation_type: "促成栽培",
    seed_type: "購入",
    seed_supplier: "タキイ種苗",
    seedling_method: "自家育苗",
    prev_crop_name: "キャベツ",
    cultivation_class: "organic",
    
    // 肥料使用履歴
    fertilizers: [
        {
            date: "2024-03-01",
            name: "牛糞堆肥",
            material: "牛糞、わら",
            maker: "地元堆肥センター",
            amount: "2000",
            notes: "元肥として施用"
        },
        {
            date: "2024-04-15",
            name: "ぼかし肥料",
            material: "米ぬか、魚粉、油かす",
            maker: "自家製",
            amount: "150",
            notes: "開花期の追肥"
        },
        {
            date: "2024-05-20",
            name: "液肥（魚エキス）",
            material: "魚エキス、海藻",
            maker: "○○資材",
            amount: "50",
            notes: "着果期の追肥"
        },
        {
            date: "2024-06-10",
            name: "ぼかし肥料",
            material: "米ぬか、魚粉、油かす",
            maker: "自家製",
            amount: "100",
            notes: "収穫期の追肥"
        }
    ],
    
    // 農薬使用履歴
    pesticides: [
        {
            date: "2024-05-10",
            name: "ニーム油乳剤",
            ingredient: "アザジラクチン",
            maker: "○○資材",
            dilution: "500倍",
            target: "アブラムシ、コナジラミ"
        },
        {
            date: "2024-05-25",
            name: "バチルス菌剤",
            ingredient: "バチルス・ズブチリス",
            maker: "△△農材",
            dilution: "1000倍",
            target: "灰色かび病予防"
        },
        {
            date: "2024-06-15",
            name: "ニーム油乳剤",
            ingredient: "アザジラクチン",
            maker: "○○資材",
            dilution: "500倍",
            target: "ハダニ、アブラムシ"
        }
    ],
    
    // 作業記録
    works: [
        {
            type: "seeding",
            content: "育苗ポットに播種",
            startDate: "2024-02-10",
            endDate: "2024-02-10",
            fertRef: "",
            pestRef: "",
            notes: "ハウス内で育苗開始"
        },
        {
            type: "seeding",
            content: "育苗管理（温度・水管理）",
            startDate: "2024-02-11",
            endDate: "2024-03-14",
            fertRef: "",
            pestRef: "",
            notes: "日中25℃、夜間15℃を維持"
        },
        {
            type: "fertilizer",
            content: "畝立て・元肥施用",
            startDate: "2024-03-01",
            endDate: "2024-03-05",
            fertRef: "①",
            pestRef: "",
            notes: "幅120cm、高さ20cmの畝"
        },
        {
            type: "planting",
            content: "本圃定植",
            startDate: "2024-03-15",
            endDate: "2024-03-20",
            fertRef: "",
            pestRef: "",
            notes: "株間40cm、条間60cm。マルチ張り"
        },
        {
            type: "watering",
            content: "灌水（点滴チューブ）",
            startDate: "2024-03-21",
            endDate: "2024-07-31",
            fertRef: "",
            pestRef: "",
            notes: "晴天時は毎朝1時間"
        },
        {
            type: "pruning",
            content: "芽かき・誘引",
            startDate: "2024-04-01",
            endDate: "2024-07-15",
            fertRef: "",
            pestRef: "",
            notes: "週2回実施。1本仕立て"
        },
        {
            type: "fertilizer",
            content: "追肥（1回目）",
            startDate: "2024-04-15",
            endDate: "2024-04-15",
            fertRef: "②",
            pestRef: "",
            notes: "開花始期"
        },
        {
            type: "pest-control",
            content: "病害虫防除（1回目）",
            startDate: "2024-05-10",
            endDate: "2024-05-10",
            fertRef: "",
            pestRef: "①",
            notes: "アブラムシ発生のため"
        },
        {
            type: "fertilizer",
            content: "追肥（2回目）",
            startDate: "2024-05-20",
            endDate: "2024-05-20",
            fertRef: "③",
            pestRef: "",
            notes: "着果期"
        },
        {
            type: "pest-control",
            content: "病害虫防除（2回目）",
            startDate: "2024-05-25",
            endDate: "2024-05-25",
            fertRef: "",
            pestRef: "②",
            notes: "灰色かび病予防"
        },
        {
            type: "harvest",
            content: "収穫開始",
            startDate: "2024-05-25",
            endDate: "2024-07-31",
            fertRef: "",
            pestRef: "",
            notes: "完熟したものから順次収穫"
        },
        {
            type: "fertilizer",
            content: "追肥（3回目）",
            startDate: "2024-06-10",
            endDate: "2024-06-10",
            fertRef: "④",
            pestRef: "",
            notes: "収穫期の樹勢維持"
        },
        {
            type: "pest-control",
            content: "病害虫防除（3回目）",
            startDate: "2024-06-15",
            endDate: "2024-06-15",
            fertRef: "",
            pestRef: "③",
            notes: "ハダニ発生のため"
        },
        {
            type: "weeding",
            content: "除草作業",
            startDate: "2024-04-01",
            endDate: "2024-07-15",
            fertRef: "",
            pestRef: "",
            notes: "マルチ周辺、通路の除草。月2回"
        },
        {
            type: "pruning",
            content: "下葉かき",
            startDate: "2024-06-01",
            endDate: "2024-07-15",
            fertRef: "",
            pestRef: "",
            notes: "通気性確保のため週1回"
        },
        {
            type: "other",
            content: "片付け・残渣処理",
            startDate: "2024-08-01",
            endDate: "2024-08-10",
            fertRef: "",
            pestRef: "",
            notes: "支柱撤去、マルチ撤去"
        }
    ]
};

// サンプルデータを各フィールドに自動入力する関数
function fillSampleData() {
    // 基本情報
    document.getElementById('recorder_name').value = sampleData.recorder_name;
    document.getElementById('recorder_org').value = sampleData.recorder_org;
    document.getElementById('recorder_address').value = sampleData.recorder_address;
    document.getElementById('recorder_tel').value = sampleData.recorder_tel;
    document.getElementById('recorder_fax').value = sampleData.recorder_fax;
    document.getElementById('producer_name').value = sampleData.producer_name;
    document.getElementById('producer_org').value = sampleData.producer_org;
    document.getElementById('product_name').value = sampleData.product_name;
    document.getElementById('product_spec').value = sampleData.product_spec;
    document.getElementById('cultivation_variety').value = sampleData.cultivation_variety;
    document.getElementById('planting_area').value = sampleData.planting_area;
    document.getElementById('plant_count').value = sampleData.plant_count;
    document.getElementById('expected_yield').value = sampleData.expected_yield;
    document.getElementById('cultivation_type').value = sampleData.cultivation_type;
    document.getElementById('seed_type').value = sampleData.seed_type;
    document.getElementById('seed_supplier').value = sampleData.seed_supplier;
    document.getElementById('seedling_method').value = sampleData.seedling_method;
    document.getElementById('prev_crop_name').value = sampleData.prev_crop_name;
    document.getElementById('cultivation_class').value = sampleData.cultivation_class;
    
    // 肥料テーブル
    const fertTable = document.querySelector('#fertilizer-table tbody');
    fertTable.innerHTML = '';
    sampleData.fertilizers.forEach((fert, i) => {
        addFertilizerRow();
        const row = fertTable.rows[i];
        row.querySelector('.fert-date').value = fert.date;
        row.querySelector('.fert-name').value = fert.name;
        row.querySelector('.fert-material').value = fert.material;
        row.querySelector('.fert-maker').value = fert.maker;
        row.querySelector('.fert-amount').value = fert.amount;
        row.querySelector('.fert-notes').value = fert.notes;
    });
    
    // 農薬テーブル
    const pestTable = document.querySelector('#pesticide-table tbody');
    pestTable.innerHTML = '';
    sampleData.pesticides.forEach((pest, i) => {
        addPesticideRow();
        const row = pestTable.rows[i];
        row.querySelector('.pest-date').value = pest.date;
        row.querySelector('.pest-name').value = pest.name;
        row.querySelector('.pest-ingredient').value = pest.ingredient;
        row.querySelector('.pest-maker').value = pest.maker;
        row.querySelector('.pest-dilution').value = pest.dilution;
        row.querySelector('.pest-target').value = pest.target;
    });
    
    // 作業記録テーブル
    const workTable = document.querySelector('#work-table tbody');
    workTable.innerHTML = '';
    sampleData.works.forEach((work, i) => {
        addWorkRow();
        const row = workTable.rows[i];
        row.querySelector('.work-type').value = work.type;
        row.querySelector('.work-content').value = work.content;
        row.querySelector('.work-start').value = work.startDate;
        row.querySelector('.work-end').value = work.endDate;
        row.querySelector('.work-fert-ref').value = work.fertRef;
        row.querySelector('.work-pest-ref').value = work.pestRef;
        row.querySelector('.work-notes').value = work.notes;
    });
    
    // タイムラインを更新
    updateWorkTimeline();
    
    console.log('✅ サンプルデータを入力しました！');
    console.log('「💾 保存」ボタンをクリックしてデータを保存してください。');
}

// 実行
console.log('='.repeat(60));
console.log('🌱 栽培履歴サンプルデータ生成スクリプト');
console.log('='.repeat(60));
console.log('');
console.log('📋 サンプル内容:');
console.log('  - 商品: ミニトマト（アイコ）');
console.log('  - 栽培区分: 有機栽培');
console.log('  - 肥料: 4回（元肥 + 追肥3回）');
console.log('  - 農薬: 3回（天然資材のみ）');
console.log('  - 作業: 16項目（播種から片付けまで）');
console.log('');
console.log('🚀 実行方法:');
console.log('  fillSampleData()');
console.log('');
console.log('='.repeat(60));
