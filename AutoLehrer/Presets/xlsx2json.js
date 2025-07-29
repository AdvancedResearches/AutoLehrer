const xlsx = require('xlsx');
const fs = require('fs');

// Читаем аргументы
const args = process.argv.slice(2);
const inputFile = args[0];
const outputFile = args[1] || 'output.json';

if (!inputFile) {
  console.error('❌ Укажи входной .xlsx файл!\nПример: node xlsx2json.js input.xlsx output.json');
  process.exit(1);
}

try {
  const workbook = xlsx.readFile(inputFile);
  const result = {};

  workbook.SheetNames.forEach(sheetName => {
    const worksheet = workbook.Sheets[sheetName];
    const data = xlsx.utils.sheet_to_json(worksheet, { defval: null });
    result[sheetName] = data;
  });

  fs.writeFileSync(outputFile, JSON.stringify(result, null, 2));
  console.log(`✅ Готово! Все листы из "${inputFile}" сохранены в "${outputFile}"`);
} catch (err) {
  console.error('❌ Ошибка при обработке файла:', err.message);
  process.exit(1);
}