/*
 * Copyright (c) Tony Bogdanov <support@tonybogdanov.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const fs = require( 'fs' );

module.exports = ( filePath, template, encrypted ) => new Promise( ( resolve, reject ) => fs.writeFile(

    filePath,
    template.replace( /{encrypted}/, encrypted.hmac + encrypted.encrypted ),

    e => {

        if ( e ) {

            return reject( e );

        }

        resolve();

    }

) );
