/*
 * Copyright (c) Tony Bogdanov <support@tonybogdanov.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const process = require( './process' );

module.exports = ( files, template, password, threshold ) => new Promise( ( resolve, reject ) => {

    let active = 0;

    const run = () => {

        if ( 0 === files.length && 0 === active ) {

            return resolve();

        }

        if ( 0 === files.length || threshold <= active ) {

            return;

        }

        active++;
        process( files.shift(), template, password ).then( () => {

            active--;
            run();

        }, reject );

        run();

    };

    run();

} );
