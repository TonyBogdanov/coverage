/*
 * Copyright (c) Tony Bogdanov <support@tonybogdanov.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const fs = require( 'fs' );

module.exports = filePath => new Promise( ( resolve, reject ) => fs.readFile( filePath, 'utf8', ( e, content ) => {

    if ( e ) {

        return reject( e );

    }

    resolve( content );

} ) );
