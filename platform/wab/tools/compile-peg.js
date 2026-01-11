const fs = require('fs');
const peg = require('pegjs');
// Intentar cargar el plugin, manejando posibles rutas relativas
let coffeePlugin;
try {
    coffeePlugin = require('pegjs-coffee-plugin');
} catch (e) {
    try {
        coffeePlugin = require('../node_modules/pegjs-coffee-plugin');
    } catch (e2) {
        console.error("No encuentro pegjs-coffee-plugin");
        process.exit(1);
    }
}

const inputFile = process.argv[2];
const outputFile = process.argv[3];

if (!inputFile || !outputFile) {
    console.error("Uso: node compile-peg.js <input> <output>");
    process.exit(1);
}

console.log(`🔨 Compilando ${inputFile} -> ${outputFile}`);

const grammar = fs.readFileSync(inputFile, 'utf8');

try {
    const source = peg.generate(grammar, {
        output: 'source',
        format: 'commonjs',
        plugins: [coffeePlugin] // Usar el plugin programáticamente
    });
    
    // Asegurar directorio de destino
    const path = require('path');
    const dir = path.dirname(outputFile);
    if (!fs.existsSync(dir)){
        fs.mkdirSync(dir, { recursive: true });
    }

    fs.writeFileSync(outputFile, source);
    console.log("✅ Generado correctamente.");
} catch (e) {
    console.error("❌ Error compilando:", e.message);
    if (e.location) console.error("   En línea:", e.location.start.line, "Columna:", e.location.start.column);
    process.exit(1);
}
