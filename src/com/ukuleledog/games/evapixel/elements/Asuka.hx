package com.ukuleledog.games.evapixel.elements;

import com.ukuleledog.games.core.AnimatedObject;
import openfl.Assets;

/**
 * ...
 * @author matt
 */
class Asuka extends AnimatedObject
{

	public function new() 
	{
		super();
		
		this.bmd = Assets.getBitmapData( 'img/sprites.png' );
		
		createAnimation( 'idle', 0, 0, 1, 150, 150 );
		createAnimation( 'walkaway', 150, 0, 2, 150, 150, 0.2 );
		
		animate();
	}
	
}