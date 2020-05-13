/*
 * Copyright (c) Tony Bogdanov <support@tonybogdanov.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const path = require( 'path' );

const scan = require( './lib/scan' );
const template = require( './lib/template' );
const batchProcess = require( './lib/batch-process' );

( async () => await batchProcess( await scan(), await template(), process.argv[2], 4 ) ) ();
