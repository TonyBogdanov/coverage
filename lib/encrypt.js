/*
 * Copyright (c) Tony Bogdanov <support@tonybogdanov.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const crypto = require( 'crypto-js' );

module.exports = ( message, password ) => {

    const salt = crypto.lib.WordArray.random( 16 );
    const key = crypto.PBKDF2( password, salt, { keySize: 8, iterations: 10 } );

    const iv = crypto.lib.WordArray.random( 16 );

    const encrypted = salt.toString() + iv.toString() + crypto.AES.encrypt( message, key, {

        iv: iv,
        padding: crypto.pad.Pkcs7,
        mode: crypto.mode.CBC,

    } );

    return {

        encrypted: encrypted.toString(),
        hmac: crypto.HmacSHA256( encrypted, crypto.SHA256( password ).toString() ).toString(),

    };

};
