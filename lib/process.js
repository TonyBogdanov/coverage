/*
 * Copyright (c) Tony Bogdanov <support@tonybogdanov.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const content = require( './content' );
const encrypt = require( './encrypt' );
const generate = require( './generate' );

module.exports = ( file, template, password ) => new Promise( async ( resolve, reject ) => {

    console.log( 'Processing', file.relative );

    try {

        const encrypted = encrypt( await content( file.source ), password );
        await generate( file.target, template, encrypted );

        resolve();

    } catch ( e ) {

        reject( e );

    }

} );
