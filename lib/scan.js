/*
 * Copyright (c) Tony Bogdanov <support@tonybogdanov.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const path = require( 'path' );
const glob = require( 'glob' );

module.exports = () => new Promise( ( resolve, reject ) => {

    glob( '**/*.html', {}, ( e, files ) => {

        if ( e ) {

            return reject( e );

        }

        resolve( files.map( file => ( {

            relative: file,
            source: path.resolve( file ),
            target: path.dirname( path.resolve( file ) ) + path.sep + path.basename( file ),

        } ) ) );

    } );

} );
