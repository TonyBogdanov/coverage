<?php

/**
 * Copyright (c) Tony Bogdanov <support@tonybogdanov.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

rename( '_css', 'css' );
rename( '_js', 'js' );
rename( '_icons', 'icons' );

foreach ( new RecursiveIteratorIterator(

    new RecursiveDirectoryIterator( './' ),
    RecursiveIteratorIterator::SELF_FIRST

) as $name => $file ) {

    if ( 'html' !== pathinfo( $name, PATHINFO_EXTENSION ) ) {

        continue;

    }

    file_put_contents( $name, str_replace( [

        '_css/',
        '_js/',
        '_icons/',

    ], [

        'css/',
        'js/',
        'icons/',

    ], file_get_contents( $name ) ) );

}
