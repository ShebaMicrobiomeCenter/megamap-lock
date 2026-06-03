#!/usr/bin/env node

/**
 * Encrypt CSV files using AES-256-GCM with PBKDF2
 * Compatible with the MegaMap web viewer
 * 
 * Usage: node encrypt.js <input-file> <output-file> <password>
 * Example: node encrypt.js latest-light.csv latest-light.csv.enc "my-secure-password"
 */

const fs = require('fs');
const crypto = require('crypto');
const path = require('path');

async function encryptFile(inputFile, outputFile, password) {
    try {
        // Read input file
        if (!fs.existsSync(inputFile)) {
            throw new Error(`Input file not found: ${inputFile}`);
        }

        const data = fs.readFileSync(inputFile);
        console.log(`📄 Read file: ${inputFile} (${data.length} bytes)`);

        // Generate salt and IV
        const salt = crypto.randomBytes(16);
        const iv = crypto.randomBytes(12);
        console.log('🔑 Generated salt and IV');

        // Derive key using PBKDF2
        const key = crypto.pbkdf2Sync(password, salt, 200000, 32, 'sha256');
        console.log('🔐 Derived key using PBKDF2-SHA256 (200000 iterations)');

        // Create cipher
        const cipher = crypto.createCipheriv('aes-256-gcm', key, iv);
        
        // Encrypt
        let encrypted = cipher.update(data);
        encrypted = Buffer.concat([encrypted, cipher.final()]);
        const authTag = cipher.getAuthTag();
        
        console.log(`✅ Encrypted: ${data.length} bytes → ${encrypted.length} bytes`);

        // Create output: MEGAMAP1 header + salt + iv + ciphertext + auth tag
        const header = Buffer.from('MEGAMAP1', 'ascii');
        const output = Buffer.concat([header, salt, iv, encrypted, authTag]);

        // Write output
        fs.writeFileSync(outputFile, output);
        
        const outputSize = fs.statSync(outputFile).size;
        console.log(`💾 Saved encrypted file: ${outputFile} (${outputSize} bytes)`);
        console.log('\n✨ Encryption successful!');
        console.log(`\n📋 File format breakdown:`);
        console.log(`  - Header: 8 bytes (MEGAMAP1)`);
        console.log(`  - Salt: 16 bytes`);
        console.log(`  - IV: 12 bytes`);
        console.log(`  - Ciphertext: ${encrypted.length - 16} bytes`);
        console.log(`  - Auth tag: 16 bytes`);

        return true;
    } catch (error) {
        console.error('❌ Encryption failed:', error.message);
        return false;
    }
}

// Parse command line arguments
const args = process.argv.slice(2);

if (args.length < 3) {
    console.log('🔐 MegaMap CSV Encryptor');
    console.log('\nUsage: node encrypt.js <input-file> <output-file> <password>');
    console.log('\nExamples:');
    console.log('  node encrypt.js latest-light.csv latest-light.csv.enc "my-password"');
    console.log('  node encrypt.js data.csv data.csv.enc "secure123"');
    console.log('\nThe encrypted file can be opened with the MegaMap HTML viewer.');
    process.exit(1);
}

const [inputFile, outputFile, password] = args;

encryptFile(inputFile, outputFile, password).then(success => {
    process.exit(success ? 0 : 1);
});
