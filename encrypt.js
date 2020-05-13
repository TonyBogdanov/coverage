/*
 * Copyright (c) Tony Bogdanov <support@tonybogdanov.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const path = require( 'path' );
const glob = require( 'glob' );
const exec = require( 'child_process' ).exec;
const os = require( 'os' );

const threshold = os.cpus().length;

const sleep = async time => new Promise( resolve => setTimeout( resolve, time ) );

( async () => glob( '**/*.html', {}, async ( e, files ) => {

    if ( e ) {

        throw e;

    }

    let active = 0;

    const encrypt = file => ( async () => {

        while ( threshold <= active ) {

            await sleep( 50 );

        }

        active++;
        const absFile = path.resolve( file );

        console.log( `Encrypting (T=${threshold})`, file );

        exec(

            'node "' + path.resolve( __dirname, 'node_modules/better-staticrypt' ) +
            '" -e -o "' + absFile + '" "' + absFile + '" "' + process.argv[2] + '"',

            e => {

                if ( e ) {

                    throw e;

                }

                active--;

            }

        );

    } )();

    for ( const file of files ) {

        encrypt( file );

    }

} ) )();
