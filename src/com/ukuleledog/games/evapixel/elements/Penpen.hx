package com.ukuleledog.games.evapixel.elements;

import com.ukuleledog.games.core.AnimatedObject;
import openfl.Assets;

/**
 * ...
 * @author matt
 */
class Penpen extends AnimatedObject
{

	public function new() 
	{
		super();
		
		this.bmd = Assets.getBitmapData( 'img/sprites.png' );
		
		createAnimation( 'idle', 0, 450, 1, 150, 150 );
		
		animate();
	}
	
}